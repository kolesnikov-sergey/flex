import 'package:flutter/material.dart';

import 'security_info.dart';
import 'search_text_field.dart';
import 'models/security.dart';
import 'services/iss_client.dart';

class Quotes extends StatefulWidget {
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
    securities = fetchSecurities();
    searchController.addListener(() {
      setState(() {
        search = searchController.text;
      });
    });
  }
  void update(index) {
    setState(() {
      securities = fetchSecurities();
    });
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
                  final items = snapshot.data
                    .where((item) => item.name.toLowerCase().contains(search.toLowerCase()) 
                      || item.id.toLowerCase().contains(search.toLowerCase()) 
                    )
                    .toList();
                  return ListView.separated(
                    itemCount: items.length,
                    itemBuilder: (context, index) => _buildItem(context, index, items),
                    separatorBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider()
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error);
                }

                return RefreshProgressIndicator();
              },
            )
          ),    
        ],
      )
    );
  }

  Widget _buildItem(BuildContext context, int index, List<Security> data) {
    final quote = data[index];

    Color logoColor;

    switch(index % 4) {
      case 0:
        logoColor = Colors.red;
        break;
      case 1:
        logoColor = Colors.green;
        break;
      case 2:
        logoColor = Colors.blue;
        break;
      case 3:
        logoColor = Colors.black;
        break;
    }

    return ListTile(
      onTap: () => Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context) => SecurityInfo(name: quote.name)
      )),
      leading: CircleAvatar(
        child: Text(quote.name.substring(0, 2).toUpperCase(), style: TextStyle(color: Colors.white)),
        backgroundColor: logoColor
      ),
      title: Text(quote.name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(quote.id),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: <Widget>[
          Text(
            '${quote.last?.toStringAsFixed(quote.decimals)} \u20BD',
            textAlign: TextAlign.end,
            style: TextStyle(fontWeight: FontWeight.bold)
          ),
          Text(
            '${quote.change > 0 ? '+': ''}${quote.change?.toStringAsFixed(2)} %',
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.greenAccent)
          )
        ],
      ),
    );
  }
}
