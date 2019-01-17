import 'package:flutter/material.dart';

import 'search_text_field.dart';
import '../ui/flex_future_builder.dart';
import '../../models/security.dart';
import '../../connectors/connector.dart';
import 'quote_item.dart';

class QuotesList extends StatefulWidget {
  final Connector connector;
  final SecurityType securityType;

  QuotesList({@required this.connector, @required this.securityType});

  @override
  _State createState() => _State();
}

class _State extends State<QuotesList> {
  Future<List<Security>> _securities;
  String _search = '';
  TextEditingController _searchController = new TextEditingController();

  @override
  void initState() {
    _securities = widget.connector.getSecurities(widget.securityType);
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
      _securities = widget.connector.getSecurities(widget.securityType);
    });
  }

  void _changeSearch() {
    setState(() {
        _search = _searchController.text;
    });
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
    return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: SearchTextField(controller: _searchController),
          ),
          Flexible(
            child: FlexFutureBuilder<List<Security>>(
              future: _securities,
              builder: (context, snapshot) {
                final items = _filterSecurities(snapshot.data);

                return ListView.separated(
                  itemCount: items.length,
                  itemBuilder: (context, index) => QuoteItem(
                    security: items[index],
                    securityType: widget.securityType,
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
      );
  }
}
