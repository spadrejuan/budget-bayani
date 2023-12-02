import 'package:budget_bayani/components/round_button.dart';
import 'package:budget_bayani/db/db_helper.dart';
import 'package:budget_bayani/screens/overview_goals.dart';
import 'package:budget_bayani/screens/set_limit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progresso/progresso.dart';
import '../components/app_color.dart';
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
        future: db.retrieveLimitByThreshold('Daily'),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      const SizedBox(height: 50.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Text(
                            DateFormat.yMMMd().format(DateTime.now()),
                            style: const TextStyle(
                            color: AppColors.TextColor,
                                    ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          Expanded(
                          child: Container(
                          margin: const EdgeInsets.only(left: 40.0),
                          child: const Text(
                          'Daily Budget',
                          style: TextStyle(
                          color: AppColors.TextColor,
                          fontSize: 25,
                          ),
                          ),
                          ),
                          ),
                          // Add Spacer to push IconButton to the right
                          Container(
                          margin: const EdgeInsets.only(right: 30.0),
                          child: IconButton(
                          onPressed: () async {
                          await db.deleteLimit(snapshot.data![index].limitId!);
                          setState(() {});
                          },
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                          ),
                          ),
                          ], // Add a comma to separate the Expanded widget from the next widget
                          ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
                      width: double.infinity,
                      height: 10.0,
                      child: Progresso(
                        progress: 0.5,
                        backgroundColor: AppColors.Stroke2Color,
                        progressColor: Colors.redAccent,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Php. ${snapshot.data![index].limitAmount}',
                            style: const TextStyle(
                              color: AppColors.TextColor,
                            ),
                          ),
                          const Text(
                            ' of limit spent',
                            style: TextStyle(
                              color: AppColors.TextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      // bottomSheet: Container(
      //   color: const Color(0xff121B1F),
      //   height: 60,
      //   child: Row(
      //     children: [
      //       const Spacer(),
      //       Align(
      //         alignment: Alignment.bottomRight,
      //         child: RoundButton(
      //           icon: Icons.add,
      //           onPressed: () {
      //             Navigator.of(context).pushReplacement(MaterialPageRoute(
      //               builder: (context) => const SetLimit(),
      //             ));
      //           },
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
