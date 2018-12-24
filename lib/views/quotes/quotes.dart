import 'package:flutter/material.dart';

import 'search_text_field.dart';
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
  Future<List<Security>> securities;
  String search = '';
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    securities = widget.connector.getSecurities();
    searchController.addListener(() {
      setState(() {
        search = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Security> _filterSecurities(List<Security> list) {
    return list
      .where((item) => item.name.toLowerCase().contains(search.toLowerCase()) 
        || item.id.toLowerCase().contains(search.toLowerCase()) 
      )
    .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Котировки')
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: SearchTextField(controller: searchController),
          ),
          Flexible(
            child: FutureBuilder<List<Security>>(
              future: securities,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final items = _filterSecurities(snapshot.data);

                  return ListView.separated(
                    itemCount: items.length,
                    itemBuilder: (context, index) => QuoteItem(
                      security: items[index],
                      connector: widget.connector,
                    ),
                    separatorBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider()
                    ),
                  );
                } else if (snapshot.hasError) {
                  final snackBar = SnackBar(content: Text(snapshot.error.toString()));
                  Scaffold.of(context).showSnackBar(snackBar);
                  return Text(snapshot.error.toString());
                }

                return RefreshProgressIndicator();
              },
            )
          ),    
        ],
      )
    );
  }
}
