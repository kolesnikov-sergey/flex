import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/security.dart';
import '../../models/quote.dart';
import '../../connectors/connector.dart';
import '../security/security_info.dart';
import '../ui/number_currency.dart';

class QuoteItem extends StatefulWidget {
  final Security security;
  final SecurityType securityType;
  final Connector connector;

  QuoteItem({
    @required this.security,
    @required this.securityType,
    @required this.connector
  });

  @override
  _QuoteItemState createState() => _QuoteItemState();
}

class _QuoteItemState extends State<QuoteItem> {
  Timer _timerDelay;
  Stream<Quote> quotes;

  @override
  void initState() {
    super.initState();
    _timerDelay = Timer(Duration(seconds: 1), () {
      setState(() {
        quotes = widget.connector.subscribeQuote(widget.security.id);
      });   
    });
  }

  @override
  void dispose() {
    _timerDelay.cancel();
    widget.connector.unsubscribeQuote(widget.security.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context) => SecurityInfo(
          security: widget.security,
          securityType: widget.securityType,
          connector: widget.connector
        )
      )),
      title: Text(widget.security.name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(widget.security.id),
      trailing: StreamBuilder<Quote>(
        stream: quotes,
        builder: (context, snapshot) {
          double last = widget.security.last ?? 0;
          double change = widget.security.change ?? 0;

          if(snapshot.hasData) {
            last = snapshot.data.last ?? 0;
            change = snapshot.data.change ?? 0;
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: <Widget>[
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: NumberCurrency(
                  key: ValueKey(last),
                  value: last,
                  currency: widget.security.currency,
                  decimals: widget.security.decimals,
                  textAlign: TextAlign.end,
                  style: TextStyle(fontWeight: FontWeight.bold)
                ),
              ),
              Text(
                '${change != null && change > 0 ? '+': ''}${change?.toStringAsFixed(widget.security.decimals)}',
                textAlign: TextAlign.start,
                style: TextStyle(color: change < 0 ? Colors.red : Colors.green),
              )
            ],
          );
        }
      )
    );
  }
}