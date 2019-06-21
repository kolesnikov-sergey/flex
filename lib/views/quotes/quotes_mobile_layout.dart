import 'dart:async';

import 'package:flutter/material.dart';

import '../ui/flex_drawer.dart';
import '../ui/search_text_field.dart';
import '../ui/flex_future_builder.dart';
import '../../models/security.dart';
import '../../connectors/connector.dart';
import '../../connectors/connector_factory.dart';
import 'quote_tile.dart';
import 'quotes_list.dart';

final securityTypes = {
  SecurityType.shares: 'Акции',
  SecurityType.bonds: 'Облигации',
  SecurityType.currencies: 'Валюта',
  SecurityType.futures: 'Фьючерсы'
};

class QuotesMobileLayout extends StatefulWidget {
 
  final SecurityCallback onPressed;
  final Security selectedItem;

  QuotesMobileLayout({
    @required this.onPressed,
    this.selectedItem
  });

  @override
  _State createState() => _State();
}

class _State extends State<QuotesMobileLayout> {
  final Connector connector = ConnectorFactory.getConnector();
  Future<List<Security>> _securities;
  SecurityType securityType = SecurityType.shares;
  String _search = '';
  TextEditingController _searchController = new TextEditingController();

  @override
  void initState() {
    _securities = connector.getSecurities(securityType);
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
      _securities = connector.getSecurities(securityType);
    });
  }

  void _changeSearch() {
    setState(() {
        _search = _searchController.text;
    });
  }

  void _changeSecurityType(SecurityType type) {
    setState(() {
      securityType = type;
    });
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
      drawer: FlexDrawer(
        title: 'Инструменты',
        value: securityType,
        options: securityTypes,
        onChange: _changeSecurityType,
      ),
      appBar: AppBar(
        title: Text(securityTypes[securityType])
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: SearchTextField(controller: _searchController),
          ),
          Flexible(
            child: FlexFutureBuilder<List<Security>>(
              future: _securities,
              builder: (context, snapshot) {
                return QuotesList(
                  quotes: _filterSecurities(snapshot.data),
                  securityType: securityType,
                  onPressed: widget.onPressed,
                  selectedItem: widget.selectedItem
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
