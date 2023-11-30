import 'package:flutter/material.dart';
import '../components/AppColor.dart';
import '../components/menu_bar.dart';
class FinancialGoals extends StatefulWidget {
  const FinancialGoals({super.key});

  @override
  State<FinancialGoals> createState() => _FinancialGoalsState();
}

class _FinancialGoalsState extends State<FinancialGoals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.BGColor,
        drawer: SideMenuBar(),
        appBar: AppBar(
          title: const Text('Financial Goals'),
          backgroundColor: AppColors.PanelBGColor,
        ),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

              ]
          ),
        )
    );
  }
}
