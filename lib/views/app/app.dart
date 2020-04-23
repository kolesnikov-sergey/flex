import 'package:flutter/widgets.dart';

import 'desktop_app.dart';
import 'mobile_app.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return constraints.maxWidth > 600
          ? DesktopApp()
          : MobileApp();
      },
    );
  }
}