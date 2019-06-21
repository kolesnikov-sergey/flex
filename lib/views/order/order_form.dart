import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'number_text_field.dart';
import '../ui/row_value.dart';
import '../../connectors/connector.dart';
import '../../connectors/connector_factory.dart';
import '../../models/order.dart';
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
  Order _order;

  @override
  void initState() {
    _order = Order(
      id: widget.security.id,
      name: widget.security.name, // todo remove
      side: OrderSide.buy,
      qty: 1,
      price: widget.price == null ? widget.security.last : widget.price
    );
    super.initState();
  }

  void submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      connector.createOrder(_order);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 500),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                CupertinoSegmentedControl<OrderSide>(
                  children: {
                    OrderSide.buy: Text('Покупка', style: TextStyle(color: Colors.white)),
                    OrderSide.sell: Text('Продажа', style: TextStyle(color: Colors.white))
                  },
                  unselectedColor: Colors.black12,
                  selectedColor: Colors.blue,
                  groupValue: _order.side,
                  onValueChanged: (side) {
                    setState(() {
                      _order.side = side;
                    });
                  },
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                NumberTextField(
                  label: 'Количество',
                  placeholder: 'Количество',
                  suffixText: 'лот',
                  initialValue: _order.qty.toDouble(),
                  onSave: (value) {
                    _order.qty = value.toInt();
                  },
                  onChange: (value) {
                    setState(() {
                      _order.qty = value.toInt();           
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
                    initialValue: _order.price,
                    step: widget.security.minStep,
                    decimals: widget.security.decimals,
                    onSave: (value) {
                      _order.price = value;
                    },
                    onChange: (value) {
                      setState(() {
                        _order.price = value;           
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
                    value: widget.security.lotSize * _order.qty * (_order.type == OrderType.market ? widget.security.last : _order.price),
                    currency: widget.security.currency,
                    decimals: widget.security.decimals,
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                RaisedButton(
                  color: Theme.of(context).buttonColor,
                  child: Text(_order.side == OrderSide.buy ? 'КУПИТЬ' : 'ПРОДАТЬ'),
                  onPressed: submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}