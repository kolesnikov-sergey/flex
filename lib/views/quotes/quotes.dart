import 'package:flutter/material.dart';

import 'search_text_field.dart';
import '../ui/flex_dropdown.dart';
import '../ui/flex_future_builder.dart';
import '../../models/security.dart';
import '../../connectors/connector.dart';
import 'quote_item.dart';

class Quotes extends StatefulWidget {
  final Connector connector;

  Quotes({@required this.connector});

  @override
  _State createState() => _State();
}

class _State extends State<Quotes> {
  Future<List<Security>> _securities;
  String _search = '';
  SecurityType _securityType = SecurityType.shares;
  TextEditingController _searchController = new TextEditingController();

  final _securityTypes = {
    SecurityType.shares: 'Акции',
    SecurityType.bonds: 'Облигации',
    SecurityType.currencies: 'Валюта',
    SecurityType.futures: 'Фьючерсы'
  };

  @override
  void initState() {
    _securities = widget.connector.getSecurities(_securityType);
    _searchController.addListener(_changeSearch);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _load() {
    setState(() {
      _securities = widget.connector.getSecurities(_securityType);
    });
  }

  void _changeSearch() {
    setState(() {
        _search = _searchController.text;
    });
  }

  void _changeSecurityType(SecurityType securityType) {
    _securityType = securityType;
    _load();
  }

  List<Security> _filterSecurities(List<Security> list) {
    return list
      .where((item) => item.name.toLowerCase().contains(_search?.toLowerCase())
        || item.id.toLowerCase().contains(_search?.toLowerCase())
      )
    .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: FlexDropdown(
          initialValue: _securityType,
          items: _securityTypes,
          onSelected: _changeSecurityType,
        )
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: SearchTextField(controller: _searchController),
          ),
          Flexible(
            child: FlexFutureBuilder<List<Security>>(
              future: _securities,
              successBuilder: (context, snapshot) {
                final items = _filterSecurities(snapshot.data);

                return ListView.separated(
                  itemCount: items.length,
                  itemBuilder: (context, index) => QuoteItem(
                    security: items[index],
                    securityType: _securityType,
                    connector: widget.connector,
                  ),
                  separatorBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(height: 1)
                  ),
                );
              },
              onRetry: _load,
            )
          ),    
        ],
      )
    );
  }
}
