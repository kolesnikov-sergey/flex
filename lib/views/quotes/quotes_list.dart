import 'package:flutter/material.dart';

import '../../models/security.dart';
import 'quote_tile.dart';

class QuotesList extends StatelessWidget {
  final List<Security> quotes;
  final SecurityType securityType;
  final Security selectedItem;
  final Function(Security) onPressed;

  QuotesList(
      {@required this.quotes,
      @required this.securityType,
      @required this.selectedItem,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.separated(
        itemCount: quotes.length,
        itemBuilder: (context, index) => QuoteTile(
          security: quotes[index],
          securityType: securityType,
          onPressed: onPressed,
          selected: quotes[index] == selectedItem,
        ),
        separatorBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(height: 1, thickness: 1)),
      ),
    );
  }
}
