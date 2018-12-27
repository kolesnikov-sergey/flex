import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'option.dart';

class More extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ещё')
      ),
      body: ListView(
        children: <Widget>[
          Option(
            text: 'Настройки',
            icon: Icons.settings,
          ),
          Divider(),
          Option(
            text: 'Поддержка',
            icon: Icons.help,
          ),
          Divider(),
          Option(
            text: 'О приложении',
            icon: Icons.info,
          )
        ],
      )
    );
  }
}