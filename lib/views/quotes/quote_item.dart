import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/security.dart';
import '../../models/quote.dart';
import '../../connectors/connector.dart';
import '../ui/number_currency.dart';

typedef void SecurityCallback(Security security, SecurityType type);

class QuoteItem extends StatefulWidget {
  final Security security;
  final SecurityType securityType;
  final Connector connector;
  final SecurityCallback onPressed;
  final bool selected;

  QuoteItem({
    @required this.security,
    @required this.securityType,
    @required this.connector,
    @required this.onPressed,
    this.selected = true
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

  //todo не уверен что это должно быть здесь
  String _getCurrency() {
    switch(widget.securityType) {
      case SecurityType.bonds:
        return '%';
      case SecurityType.futures:
        return 'pt';
      default:
        return widget.security.currency;
    }
  }

  @override
  void dispose() {
    _timerDelay.cancel();
    widget.connector.unsubscribeQuote(widget.security.id);
    super.dispose();
  }

  void _navigateToSecurity() {
    widget.onPressed(widget.security, widget.securityType);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _navigateToSecurity,
      title: Text(widget.security.name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(widget.security.id),
      selected: widget.selected,
      trailing: StreamBuilder<Quote>(
        stream: quotes,
        builder: (context, snapshot) {
          double last = widget.security.last;
          double change = widget.security.change;

          if(snapshot.hasData) {
            last = snapshot.data.last;
            change = snapshot.data.change;
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
                  currency: _getCurrency(),
                  decimals: widget.security.decimals,
                  textAlign: TextAlign.end,
                  style: TextStyle(fontWeight: FontWeight.bold)
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: NumberCurrency(
                  key: ValueKey(change),
                  value: change,
                  currency: _getCurrency(),
                  decimals: widget.security.decimals,
                  prefix: change != null && change > 0 ? '+': '',
                  textAlign: TextAlign.end,
                  style: TextStyle(color: change < 0 ? Colors.pink : Colors.green)
                ),
              )
            ],
          );
        }
      )
    );
  }
}