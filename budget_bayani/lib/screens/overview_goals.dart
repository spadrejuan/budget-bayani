import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progresso/progresso.dart';
import '../components/AppColor.dart';
import '../db/db_helper.dart';
import 'financial_goals.dart';
class OverviewGoals extends StatefulWidget {
  const OverviewGoals({super.key});

  @override
  State<OverviewGoals> createState() => _OverviewGoalsState();
}

class _OverviewGoalsState extends State<OverviewGoals> {
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Overview of Financial Goals'),
        backgroundColor: AppColors.PanelBGColor,
        leading: IconButton(
          icon: const Icon(
              Icons.arrow_back,
              color: Color(0xffCCD3D9)
          ),
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const FinancialGoals(),
            ));
          },
        ),
      ),
      body: FutureBuilder(
        // TODO add method to query only finished goals
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
                            await db.deleteUser(snapshot.data![index].goalId!);
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
    );
  }
}
