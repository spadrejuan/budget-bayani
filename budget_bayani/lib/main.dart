import 'package:budget_bayani/screens/cash_flow_tracking_page.dart';
import 'package:budget_bayani/components/menu_bar.dart';
import 'package:budget_bayani/screens/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:budget_bayani/components/app_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: AppColors.PanelBGColor,
        scaffoldBackgroundColor: AppColors.PanelBGColor,
      ),
      home: LandingPage()
      // home: LandingPage(),
      // theme: ThemeData.dark().copyWith(
      // primaryColor: const Color(0xFF0A0E21),
      // scaffoldBackgroundColor: const Color(0xFF0A0E21),
      // )
    );
  }
}


