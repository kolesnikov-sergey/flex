import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'desktop_app.dart';
import 'mobile_app.dart';
import '../../models/layout_type.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return context.watch<LayoutType>() == LayoutType.desktop
        ? DesktopApp()
        : MobileApp();
  }
}
