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

extension Navigation on BuildContext {
  void pushNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  void pushReplacementNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);
  }

  void pushNamedAndRemoveUntil(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  void pop() {
    Navigator.of(this).pop();
  }
}
