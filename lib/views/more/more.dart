import 'package:dynamic_theme/dynamic_theme.dart';
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
          Option(
            text: 'Темная тема',
            icon: Icons.settings,
            trailing: Switch(
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (value) {
                DynamicTheme.of(context).setBrightness(value ? Brightness.dark: Brightness.light);
              }
            ),
          ),
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