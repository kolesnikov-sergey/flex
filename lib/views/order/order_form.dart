import 'package:flutter/material.dart';

import 'order_type_select.dart';
import 'number_text_field.dart';
import 'order_submit.dart';
import 'row_value.dart';
import '../../models/order_data.dart';
import '../../models/security.dart';

class OrderForm extends StatefulWidget {
  final Security security;

  OrderForm({@required this.security});

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final _formKey = GlobalKey<FormState>();
  OrderData _orderData;

  @override
  void initState() {
    _orderData = OrderData(
      type: OrderType.limit,
      qty: 1,
      price: widget.security.last
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          OrderTypeSelect(
            value: _orderData.type,
            onValueChanged: (val) {
              setState(() {
                _orderData.type = val;        
              });    
            },
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          NumberTextField(
            label: 'Количество',
            placeholder: 'Количество',
            initialValue: _orderData.qty.toString(),
            onSave: (value) {
              _orderData.qty = value.toInt();
            },
            validator: (value) {
              if(value == null) {
                return 'Обязательное поле';
              }
              if(int.tryParse(value) == null) {
                return 'Обязательное поле';
              }

              return null;
            },
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          NumberTextField(
            label: 'Цена',
            placeholder: 'Цена',
            initialValue: _orderData.price.toString(),
            step: widget.security.minStep,
            decimals: widget.security.decimals,
            onSave: (value) {
              _orderData.price = value;
            },
            validator: (value) {
              if(value == null) {
                return 'Обязательное поле';
              }
              if(double.tryParse(value) == null) {
                return 'Обязательное поле';
              }

              return null;
            },
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: RowValue(
              label: 'Стоимость',
              value: '1000 P',
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          OrderSubmit(
            onBuy: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                _orderData.side = OrderSide.buy;
                Navigator.pop(context);
              }
            },
            onSell: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                _orderData.side = OrderSide.sell;
                Navigator.pop(context);
              }
            }
          )
        ],
      ),
    );
  }
}