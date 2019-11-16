import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'desktop_layout.dart';
import 'mobile_layout.dart';
import '../../models/layout_type.dart';

class Layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return constraints.maxWidth > 600
          ? Provider.value(value: LayoutType.desktop, child: DesktopLayout())
          : Provider.value(value: LayoutType.mobile, child: MobileLayout());
      },
    );
  }
}