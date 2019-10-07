import 'package:flutter/material.dart';

import 'ui/pages/home/home.dart';
import 'ui/style/colors.dart';
import 'utils/service_locator.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mwaslat',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primary,
        accentColor: AppColors.accent,
        accentColorBrightness: Brightness.light,
        backgroundColor: AppColors.background,
        scaffoldBackgroundColor: AppColors.background,
        cursorColor: AppColors.primary,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
