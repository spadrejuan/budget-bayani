import 'package:budget_bayani/components/round_button.dart';
import 'package:budget_bayani/db/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  late Goal _goal;
  late DBHelper db;
  @override
  void initState(){
    super.initState();
    db = DBHelper();
    db.initDB().whenComplete(() async {
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.BGColor,
        drawer: SideMenuBar(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Financial Goals'),
          backgroundColor: AppColors.PanelBGColor,
        ),
        body: FutureBuilder(
          future: db.retrieveGoals(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                  child: CircularProgressIndicator()
              );
            }
            if (!snapshot.hasData){
              return const Center(
                  child: Text(
                    'No data to show',
                    style: TextStyle(color: AppColors.TextColor),
                  ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index){
                return Container(
                  child: Text(
                    "ID: ${snapshot.data![index].goalId}Name: ${snapshot.data![index].goalName}"
                        "Start: ${snapshot.data![index].goalStart}End: ${snapshot.data![index].goalEnd}"
                        "Ampunt: ${snapshot.data![index].goalAmount}Category: ${snapshot.data![index].incomeCategory}",
                  ),
                );
              },
            );
          },
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
