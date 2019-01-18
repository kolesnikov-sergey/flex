import 'package:flutter/material.dart';

class TabsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Tab> tabs;

  TabsAppBar({@required this.tabs});

  @override
  final Size preferredSize = Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      elevation: 4,
      child: SafeArea(
        top: true,
        child: TabBar(
          isScrollable: true,
          tabs: tabs,
        ),
      ),
    );
  }
}