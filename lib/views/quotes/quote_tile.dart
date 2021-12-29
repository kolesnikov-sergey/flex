import 'dart:async';

import 'package:flex/models/quote.dart';
import 'package:flex/state/quotes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/security.dart';
import '../ui/number_currency.dart';
import '../ui/number_currency_and_percent.dart';

class QuoteTile extends StatefulWidget {
  final Security security;
  final SecurityType securityType;
  final Function(Security) onPressed;
  final bool selected;

  QuoteTile({
    required this.security,
    required this.securityType,
    required this.onPressed,
    this.selected = true
  });

  @override
  _QuoteTileState createState() => _QuoteTileState();
}

class _QuoteTileState extends State<QuoteTile> {
  Timer? _timerDelay;
  Function? unconnect;

  @override
  void initState() {
    super.initState();
  
    _timerDelay = Timer(Duration(milliseconds: 100), () {
      unconnect = context.read<QuotesCubit>().subscribe(widget.security.id);
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
    _timerDelay?.cancel();
 
    if (unconnect != null) {
      unconnect!();
    }
    super.dispose();
  }

  void tap() {
    widget.onPressed(widget.security);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: tap,
      title: Text(widget.security.name),
      subtitle: Text(widget.security.id),
      selected: widget.selected,
      trailing: BlocSelector<QuotesCubit, Map<String, Quote>, Quote?>(
        selector: (state) => state[widget.security.id],
        builder: (_, quote) {
          final last = quote == null ? widget.security.last : quote.last;
          final change = quote == null ?  widget.security.change : quote.change;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              NumberCurrency(
                  value: last,
                  currency: _getCurrency(),
                  decimals: widget.security.decimals,
                  style: Theme.of(context).textTheme.bodyText2
                ),
              Padding(
                padding: EdgeInsets.only(top: 2),
              ),
              NumberCurrencyAndPercent(
                  key: ValueKey(change),
                  value: change,
                  valuePercent: change / widget.security.open,
                  currency: _getCurrency(),
                  decimals: widget.security.decimals,
                  prefix: change != null && change > 0 ? '+': '',
                  style: TextStyle(color: change < 0 ? Colors.pink : Colors.green)
                ),
            ],
          );
        }
      )
    );
  }
}