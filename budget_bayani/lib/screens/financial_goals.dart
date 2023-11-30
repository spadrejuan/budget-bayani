import 'package:budget_bayani/components/round_button.dart';
import 'package:flutter/material.dart';
import '../components/AppColor.dart';
import '../components/menu_bar.dart';
import 'add_goals.dart';
import 'landing_page.dart';
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
          title: const Text('Financial Goals',),
          backgroundColor: AppColors.PanelBGColor,
        ),
        body: const SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Add goal with progress bar
                //GoalContainer,
              ]
          ),
        ),
        bottomSheet: Container(
          color: const Color(0xff121B1F),
          height: 60,
          child: Row(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: RoundButton(
                  icon: Icons.menu,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => LandingPage(),
                    ));
                  },
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: RoundButton(
                  icon: Icons.add,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const AddGoal(),
                    ));
                  },
                ),
              ),
            ],
          ),
        ),
    );
  }
}
//TODO: add the financial goal widget GoalContainer
