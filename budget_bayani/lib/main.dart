import 'package:budget_bayani/screens/landing_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(BudgetBayani());

class BudgetBayani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF0A0E21),
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
      ),
      home: LandingPage(),
    );
  }
}

