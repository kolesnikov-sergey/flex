import 'package:flutter/material.dart';

import 'quote_item.dart';
import '../../models/security.dart';

class QuotesListView extends StatelessWidget {
  final List<Security> quotes;
  final SecurityType securityType;
  final Security selectedItem;
  final SecurityCallback onPressed;

  QuotesListView({
    @required this.quotes,
    @required this.securityType,
    @required this.selectedItem,
    @required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: quotes.length,
      itemBuilder: (context, index) => QuoteItem(
        security: quotes[index],
        securityType: securityType,
        onPressed: onPressed,
        selected: quotes[index] == selectedItem,
      ),
      separatorBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Divider(height: 1)
      ),
    );
  }
}