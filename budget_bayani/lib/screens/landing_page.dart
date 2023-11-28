import 'package:budget_bayani/components/menu_bar.dart';
import 'package:flutter/material.dart';
enum DashboardViews{
  income,
  expenses
}

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late DashboardViews selectedDashboardView;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenuBar(),
    );
  }
}

