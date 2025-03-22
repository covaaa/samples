import 'package:flutter/widgets.dart';

extension XMediaQuery on BuildContext {
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);
  double get viewPaddingBottom => viewPadding.bottom;
}
