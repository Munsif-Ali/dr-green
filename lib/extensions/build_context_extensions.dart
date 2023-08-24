import 'package:flutter/material.dart';

extension Media on BuildContext {
  double get getHeight => MediaQuery.of(this).size.height;
  double get getWidth => MediaQuery.of(this).size.width;
  double get getStatusBarHeight => MediaQuery.of(this).padding.top;
  double get getBottomPadding => MediaQuery.of(this).padding.bottom;
  double get getAppBarHeight => kToolbarHeight;
  double get getBodyHeight =>
      getHeight - getStatusBarHeight - getAppBarHeight - getBottomPadding;
  double get getBodyWidth => getWidth;
  double get getBodyHeightWithoutAppBar =>
      getHeight - getStatusBarHeight - getBottomPadding;
  double get getBodyWidthWithoutAppBar => getWidth;
}
