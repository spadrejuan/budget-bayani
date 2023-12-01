import 'package:budget_bayani/components/round_button.dart';
import 'package:budget_bayani/db/db_helper.dart';
import 'package:budget_bayani/screens/overview_goals.dart';
import 'package:budget_bayani/screens/set_limit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progresso/progresso.dart';
import '../components/AppColor.dart';
import '../components/menu_bar.dart';
import '../models/goals.dart';
import 'add_goals.dart';
import 'landing_page.dart';
class BudgetPlanner extends StatefulWidget {
  const BudgetPlanner({super.key});
  @override
  State<BudgetPlanner> createState() => _BudgetPlannerState();
}
class _BudgetPlannerState extends State<BudgetPlanner> {
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
        title: const Text('Budget Planner'),
        backgroundColor: AppColors.PanelBGColor,
      ),
      body: FutureBuilder(
        future: db.retrieveLimit(),
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
              return Center(
                child: Text(
                  'ID: ' + snapshot.data![index].limitId.toString() +
                      "Amount: " + snapshot.data![index].limitAmount.toString() +
                      "Threshold: " + snapshot.data![index].limitThreshold,
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
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: RoundButton(
                icon: Icons.add,
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const SetLimit(),
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
