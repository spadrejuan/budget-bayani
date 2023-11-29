import 'package:budget_bayani/components/menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:budget_bayani/components/AppColor.dart';
import 'package:pie_chart/pie_chart.dart';

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
      backgroundColor: AppColors.BGColor,
      drawer: SideMenuBar(),
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: AppColors.PanelBGColor,
      ),
    );
  }
}

Widget PieChartContainer(context) => Container(
  child:
  PieChart(
    dataMap: {
      'Apples': 10,
      'Bananas': 15,
      'Oranges': 20,
    },
    chartType: ChartType.ring,
    animationDuration: Duration(seconds: 2),
    chartRadius: MediaQuery.of(context).size.width / 3,
  ),

);

