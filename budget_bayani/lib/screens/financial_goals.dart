import 'package:budget_bayani/components/round_button.dart';
import 'package:budget_bayani/db/db_helper.dart';
import 'package:flutter/material.dart';
import '../components/AppColor.dart';
import '../components/menu_bar.dart';
import '../models/goals.dart';
import 'add_goals.dart';
import 'landing_page.dart';
class FinancialGoals extends StatefulWidget {
  const FinancialGoals({super.key});
  @override
  State<FinancialGoals> createState() => _FinancialGoalsState();
}
class _FinancialGoalsState extends State<FinancialGoals> {
  List<Map<String, dynamic>> _goals = [];
  bool _isLoading = true;

  void _refreshGoals() async{
    final data = await DBHelper.getGoals();
    setState(() {
      _goals = data;
      _isLoading = false;
    });
  }
  @override
  void initState(){
    super.initState();
    _refreshGoals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.BGColor,
        drawer: SideMenuBar(),
        appBar: AppBar(
          title: const Text('Financial Goals',),
          backgroundColor: AppColors.PanelBGColor,
        ),
        body: _isLoading
        ? const Center(
          child: CircularProgressIndicator(),
        )
        :  ListView.builder(
          itemCount: _goals.length,
          itemBuilder: (context, index) => ListView(
                children: [
                  Text(_goals[index]['goal_id']),
                  Text(_goals[index]['goal_name']),
                  Text(_goals[index]['goal_start']),
                  Text(_goals[index]['goal_end']),
                  Text(_goals[index]['goal_amount']),
                  Text(_goals[index]['income_category']),
                ],
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
