import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'ui/pages/home/home.dart';
import 'ui/style/colors.dart';
import 'utils/service_locator.dart';

void main() async {
  setupServiceLocator();
  BlocSupervisor.delegate = await HydratedBlocDelegate.build();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Backbone',
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
