import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/security.dart';
import '../../models/quote.dart';
import '../../connectors/connector.dart';
import '../../connectors/connector_factory.dart';
import '../ui/number_currency.dart';
import '../ui/number_currency_and_percent.dart';

typedef void SecurityCallback(Security security, SecurityType type);

class QuoteTile extends StatefulWidget {
  final Security security;
  final SecurityType securityType;
  final SecurityCallback onPressed;
  final bool selected;

  QuoteTile({
    @required this.security,
    @required this.securityType,
    @required this.onPressed,
    this.selected = true
  });

  @override
  _QuoteTileState createState() => _QuoteTileState();
}

class _QuoteTileState extends State<QuoteTile> {
  final Connector connector = ConnectorFactory.getConnector();
  Timer _timerDelay;
  Stream<Quote> quotes;

  @override
  void initState() {
    super.initState();
    _timerDelay = Timer(Duration(seconds: 1), () {
      setState(() {
        quotes = connector.subscribeQuote(widget.security.id);
      });   
    });
  }

  // TODO не уверен что это должно быть здесь
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
    connector.unsubscribeQuote(widget.security.id);
    super.dispose();
  }

  void tap() {
    widget.onPressed(widget.security, widget.securityType);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: tap,
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: NumberCurrency(
                  key: ValueKey(last),
                  value: last,
                  currency: _getCurrency(),
                  decimals: widget.security.decimals,
                  style: Theme.of(context).textTheme.body2
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: NumberCurrencyAndPercent(
                  key: ValueKey(change),
                  value: change,
                  valuePercent: change / widget.security.open,
                  currency: _getCurrency(),
                  decimals: widget.security.decimals,
                  prefix: change != null && change > 0 ? '+': '',
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