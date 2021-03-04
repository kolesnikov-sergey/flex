import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../models/security.dart';
import '../../models/layout_type.dart';
import '../../state/securities_state.dart';
import '../ui/flex_dropdown.dart';
import '../ui/search_text_field.dart';
import '../ui/loadable.dart';

import 'quotes_list.dart';

final securityTypes = {
  SecurityType.shares: 'Акции',
  SecurityType.bonds: 'Облигации',
  SecurityType.currencies: 'Валюта',
  SecurityType.futures: 'Фьючерсы'
};

class QuotesView extends StatefulWidget {
  QuotesView();

  @override
  _State createState() => _State();
}

class _State extends State<QuotesView> {
  final _securitiesState = GetIt.I<SecuritiesState>();

  @override
  void initState() {
    void load() async {
      await _securitiesState.loadSecurities(SecurityType.shares);
      if (_securitiesState.current == null && _securitiesState.filteredSecurities.length > 0) {
        _securitiesState.setCurrent(_securitiesState.filteredSecurities[0]);
      }
    }

    load();

    super.initState();
  }

  void _selectSecurity(Security security) {
    _securitiesState.setCurrent(security);

    final layoutType = Provider.of<LayoutType>(context, listen: false);

    if (layoutType == LayoutType.mobile) {
      Navigator.pushNamed(context, '/security');
    }
  }

  @override
  Widget build(BuildContext context) {
    final layoutType = Provider.of<LayoutType>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Observer(builder: (_) {
          return FlexDropdown(
            value: _securitiesState.securityType,
            items: securityTypes,
            onChanged: _securitiesState.loadSecurities,
          );
        }) 
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: SearchTextField(onChanged: _securitiesState.setSearch),
          ),
          Flexible(
            child: Observer(builder: (_) {
              return Loadable(
                isLoading: _securitiesState.isLoading,
                hasError: false,
                onRetry: () => _securitiesState.loadSecurities(_securitiesState.securityType),
                child: QuotesList(
                  quotes: _securitiesState.filteredSecurities,
                  securityType: _securitiesState.securityType,
                  onPressed: _selectSecurity,
                  selectedItem: layoutType == LayoutType.desktop ? _securitiesState.current : null
                ),
              );
            })
          ),    
        ],
      )
    );
  }
}
