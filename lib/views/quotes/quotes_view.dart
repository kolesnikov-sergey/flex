import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/securities_state.dart';
import '../../models/security.dart';
import '../ui/flex_drawer.dart';
import '../ui/search_text_field.dart';
import '../ui/loadable.dart';

import 'quote_tile.dart';
import 'quotes_list.dart';

final securityTypes = {
  SecurityType.shares: 'Акции',
  SecurityType.bonds: 'Облигации',
  SecurityType.currencies: 'Валюта',
  SecurityType.futures: 'Фьючерсы'
};

class QuotesView extends StatefulWidget {
  final SecurityCallback onPressed;
  final Security selectedItem;

  QuotesView({
    @required this.onPressed,
    this.selectedItem
  });

  @override
  _State createState() => _State();
}

class _State extends State<QuotesView> {
  @override
  void initState() {
    final securitiesState = Provider.of<SecuritiesState>(context, listen: false);
    Future.microtask(() => securitiesState.loadSecurities(SecurityType.shares));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final securitiesState = Provider.of<SecuritiesState>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      drawer: FlexDrawer(
        title: 'Инструменты',
        value: securitiesState.getSecurityType(),
        options: securityTypes,
        onChange: (type) => securitiesState.loadSecurities(type),
      ),
      appBar: AppBar(
        title: Text(securityTypes[securitiesState.getSecurityType()])
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: SearchTextField(onChanged: securitiesState.setSearch),
          ),
          Flexible(
            child: Loadable(
              isLoading: securitiesState.getIsLoading(),
              hasError: false,
              onRetry: () => securitiesState.loadSecurities(securitiesState.getSecurityType()),
              child: QuotesList(
                quotes: securitiesState.getSecurities(),
                securityType: securitiesState.getSecurityType(),
                onPressed: widget.onPressed,
                selectedItem: widget.selectedItem
              ),
            )
          ),    
        ],
      )
    );
  }
}
