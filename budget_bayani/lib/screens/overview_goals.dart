import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progresso/progresso.dart';
import '../components/app_color.dart';
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
        future: db.retrieveExpiredGoals(),
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
                    SizedBox(height: 50.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(
                          snapshot.data![index].goalStart,
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
                    SizedBox(height: 10.0),
                    // Add a SizedBox for spacing
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 40.0),
                            child: Text(
                              snapshot.data![index].goalName,
                              style: const TextStyle(
                                color: AppColors.TextColor,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                        // Add Spacer to push IconButton to the right
                        Container(
                          margin: EdgeInsets.only(right: 30.0),
                          child: IconButton(
                            onPressed: () async {
                              await db.deleteGoal(snapshot.data![index].goalId!);
                              setState(() {});
                            },
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                          ),
                        ),
                      ], // Add a comma to separate the Expanded widget from the next widget
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
                      width: double.infinity,
                      height: 10.0,
                      child: Progresso(
                        progress: 0.5,
                        backgroundColor: AppColors.Stroke2Color,
                        progressColor: Colors.redAccent,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Php. 100',
                            style: TextStyle(
                              color: AppColors.TextColor,
                            ),
                          ),
                          Text(
                            ' of ${snapshot.data![index].goalAmount} saved[${snapshot.data![index].incomeCategory}]',
                            style: const TextStyle(
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
    );
  }
}
