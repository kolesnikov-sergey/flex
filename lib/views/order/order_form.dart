import 'package:flutter/material.dart';

import 'number_text_field.dart';
import 'order_submit.dart';
import '../ui/row_value.dart';
import '../../connectors/connector.dart';
import '../../connectors/connector_factory.dart';
import '../../models/order_data.dart';
import '../../models/security.dart';
import '../../tools/currency_symbol.dart';
import '../ui/number_currency.dart';

class OrderForm extends StatefulWidget {
  final Security security;
  final OrderType orderType;
  final double price;

  OrderForm({
    @required this.security,
    @required this.orderType,
    this.price
  });

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final Connector connector = ConnectorFactory.getConnector();

  final _formKey = GlobalKey<FormState>();
  OrderData _orderData;

  @override
  void initState() {
    _orderData = OrderData(
      id: widget.security.id,
      name: widget.security.name, // todo remove
      qty: 1,
      price: widget.price == null ? widget.security.last : widget.price
    );
    super.initState();
  }

  void submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      connector.createOrder(_orderData);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            NumberTextField(
              label: 'Количество',
              placeholder: 'Количество',
              suffixText: 'лот',
              initialValue: _orderData.qty.toDouble(),
              onSave: (value) {
                _orderData.qty = value.toInt();
              },
              onChange: (value) {
                setState(() {
                  _orderData.qty = value.toInt();           
                });
              },
              validator: (value) {
                if(value == null) {
                  return 'Обязательное поле';
                }
                final parsed = int.tryParse(value);
                if(parsed == null || parsed < 0 || parsed > 100000) {
                  return 'Введите число от 0 до 100 000';
                }

                return null;
              },
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Visibility(
              visible: widget.orderType != OrderType.market,
              child: NumberTextField(
              label: 'Цена',
              placeholder: 'Цена',
              suffixText: CurrencySymbol.getCurrencySymbol('RUB'),
              initialValue: _orderData.price,
              step: widget.security.minStep,
              decimals: widget.security.decimals,
              onSave: (value) {
                _orderData.price = value;
              },
              onChange: (value) {
                setState(() {
                  _orderData.price = value;           
                });
              },
              validator: (value) {
                if(value == null) {
                  return 'Обязательное поле';
                }
                final parsed = double.tryParse(value);
                if(parsed == null || parsed < 0 || parsed > 1000000) {
                  return 'Введите число от 0 до 1 000 000';
                }

                return null;
              },
            ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            RowValue(
                label: 'Стоимость',
                value: NumberCurrency(
                  value: widget.security.lotSize * _orderData.qty * (_orderData.type == OrderType.market ? widget.security.last : _orderData.price),
                  currency: widget.security.currency,
                  decimals: widget.security.decimals,
                  style: Theme.of(context).textTheme.body2,
                ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            OrderSubmit(
              onBuy: () {
                _orderData.side = OrderSide.buy;
                submit();
              },
              onSell: () {
                _orderData.side = OrderSide.sell;
                submit();
              }
            )
          ],
        ),
      ),
    );
  }
}