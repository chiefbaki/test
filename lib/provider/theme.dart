import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/provider/themes.dart';

class ThemeChange extends ChangeNotifier {
  bool isDark = false;
  void changeTheme() {
    isDark = !isDark;
    notifyListeners();
  }

  ThemeData get getCurrentTheme => isDark ? darkTheme : lightTheme;
}
