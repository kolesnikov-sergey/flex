import 'package:flutter/material.dart';

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
          Padding(padding: EdgeInsets.all(10)),
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
            text: 'Чат',
            icon: Icons.chat,
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