import 'package:budget_bayani/components/round_button.dart';
import 'package:budget_bayani/db/db_helper.dart';
import 'package:budget_bayani/screens/overview_goals.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progresso/progresso.dart';
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
          // TODO fix dates to output Month, Day, Year
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
                return Center(
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Text(
                            snapshot.data![index].goalEnd,
                            style: const TextStyle(
                              color: AppColors.TextColor,
                            ),
                          ),
                          const Text(
                            ' - ',
                            style: TextStyle(
                              color: AppColors.TextColor,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                           snapshot.data![index].goalEnd,
                            style: const TextStyle(
                              color: AppColors.TextColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        snapshot.data![index].goalName,
                        style: const TextStyle(
                          color: AppColors.TextColor,
                          fontSize: 15,
                          ),
                        ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await db.deleteGoal(snapshot.data![index].goalId!);
                              setState(() {
                              });
                            },
                            icon: const Icon(
                              Icons.delete
                            ),
                            color: Colors.red,
                          ),
                          Progresso(
                            //TODO add value for progress bar using income category
                            progress: 0.5,
                            backgroundColor: AppColors.Stroke2Color,
                            progressColor: Colors.blueAccent,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            // TODO add values of added categories here
                              'Php. 100',
                              style: TextStyle(
                              color: AppColors.TextColor,
                              ),
                            ),
                          Text(
                            ' of ${snapshot.data![index].goalAmount}saved[${snapshot.data![index].incomeCategory}]',
                            style: const TextStyle(
                              color: AppColors.TextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const OverviewGoals(),
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
