import 'package:flutter/material.dart';

import 'search_text_field.dart';
import '../../models/security.dart';
import '../../connectors/connector.dart';
import 'quote_item.dart';

class Drop extends StatelessWidget {
  final SecurityType initialValue;
  final Map<SecurityType, String> items;
  final PopupMenuItemSelected onSelected;

  Drop({@required this.initialValue, @required this.items, @required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return AppBarDropdown(
      initialValue: initialValue,
      items: items,
      onSelected: onSelected,
    );
  }

}

class AppBarDropdown extends StatefulWidget {
  final SecurityType initialValue;
  final Map<SecurityType, String> items;
  final PopupMenuItemSelected onSelected;

  AppBarDropdown({@required this.initialValue, @required this.items, @required this.onSelected});

  @override
  _AppBarDropdownState createState() => _AppBarDropdownState();
}

class _AppBarDropdownState extends State<AppBarDropdown> {
  SecurityType value;

  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      initialValue: value,
      child: Row(
        mainAxisAlignment: Theme.of(context).platform == TargetPlatform.iOS
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
        children: [
          Text(widget.items[value]),
          Icon(Icons.arrow_drop_down)
        ],
      ),
      onSelected: (val) {
        setState(() {
          value = val;    
        });
        widget.onSelected(val);
      },
      itemBuilder: (context) => widget.items.keys
        .map((key) => PopupMenuItem(
          value: key,
          child: Text(widget.items[key]),
        ))
        .toList(),
    );
  }
}

class Quotes extends StatefulWidget {
  final Connector connector;

  Quotes({@required this.connector});

  @override
  _State createState() => _State();
}

class _State extends State<Quotes> {
  Future<List<Security>> securities;
  String search = '';
  SecurityType securityType = SecurityType.shares;
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    securities = widget.connector.getSecurities(securityType);
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
        title: Drop(
          initialValue: securityType,
          items: {
            SecurityType.shares: 'Акции',
            SecurityType.bonds: 'Облигации',
            SecurityType.currencies: 'Валюта',
            SecurityType.futures: 'Фьючерсы'
          },
          onSelected: (val) {
            setState(() {
              securityType = val;
              securities = widget.connector.getSecurities(securityType);
            });
          },
        )
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
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return RefreshProgressIndicator();
                }
                if (snapshot.hasData) {
                  final items = _filterSecurities(snapshot.data);

                  return ListView.separated(
                    itemCount: items.length,
                    itemBuilder: (context, index) => QuoteItem(
                      security: items[index],
                      securityType: securityType,
                      connector: widget.connector,
                    ),
                    separatorBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(height: 1)
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
