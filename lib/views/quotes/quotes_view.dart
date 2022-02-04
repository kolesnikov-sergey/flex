import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../state/securities.dart';
import '../../models/security.dart';
import '../../models/layout_type.dart';
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
  @override
  void initState() {
    void load() async {
      final cubit = context.read<SecuritiesCubit>();
      await cubit.load(SecurityType.shares);
      if (cubit.state.current == null && cubit.state.securities.length > 0) {
        cubit.setCurrentSecurity(cubit.state.securities[0]);
      }
    }

    load();

    super.initState();
  }

  void _selectSecurity(Security security) {
    final cubit = context.read<SecuritiesCubit>();
    cubit.setCurrentSecurity(security);

    final layoutType = Provider.of<LayoutType>(context, listen: false);

    if (layoutType == LayoutType.mobile) {
      Navigator.pushNamed(context, '/security');
    }
  }

  void _handleSearch(String value) {
    final cubit = context.read<SecuritiesCubit>();

    cubit.setSearch(value);
  }

  void _load([SecurityType? securityType]) async {
    final cubit = context.read<SecuritiesCubit>();

    await cubit.load(securityType);
  }

  @override
  Widget build(BuildContext context) {
    final layoutType = Provider.of<LayoutType>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: BlocBuilder<SecuritiesCubit, SecuritiesState>(
          builder: (_, state) {
            return FlexDropdown(
              value: state.securityType,
              items: securityTypes,
              onChanged: _load,
            );
          }
        ) 
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: SearchTextField(onChanged: _handleSearch),
          ),
          Flexible(
            child: BlocBuilder<SecuritiesCubit, SecuritiesState>(
              builder: (_, state) {
              return Loadable(
                isLoading: state.isLoading,
                hasError: false,
                onRetry: _load,
                child: QuotesList(
                  quotes: state.securities,// TODO filtered
                  securityType: state.securityType,
                  onPressed: _selectSecurity,
                  selectedItem: layoutType == LayoutType.desktop ? state.current : null
                ),
              );
            })
          ),    
        ],
      )
    );
  }
}
