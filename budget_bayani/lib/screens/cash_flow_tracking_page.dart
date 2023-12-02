import 'package:budget_bayani/screens/add_entries.dart';
import 'package:flutter/material.dart';
import 'package:budget_bayani/components/app_color.dart';
import 'package:budget_bayani/components/menu_bar.dart';
import 'package:intl/intl.dart';
import '../db/db_helper.dart';
import '../models/income.dart';
import 'add_entries_2.dart';
class CashFlowPage extends StatefulWidget {
  @override
  State<CashFlowPage> createState() => _CashFlowPage();
}
class _CashFlowPage extends State<CashFlowPage> {
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
    double monthlyIncome = 0;
    double monthlyExpense = 0;
    double monthlyNet = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('CashFlowPage'),
        backgroundColor: AppColors.PanelBGColor,

      ),
      drawer: SideMenuBar(),
       body:
       SingleChildScrollView(
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MonthlySummary(monthlyIncome, monthlyExpense, monthlyNet),
            FutureBuilder(
              future: Future.wait([db.retrieveIncomes(), db.retrieveExpenses()]),
              // builder: (BuildContext context, incomeSnap) {
                builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
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
                List<dynamic> combinedList = [];
                if (snapshot.data![0] != null) {
                  combinedList.addAll(snapshot.data![0]);
                }
                if (snapshot.data![1] != null) {
                  combinedList.addAll(snapshot.data![1]);
                }
                combinedList.sort((a, b) => b.date.compareTo(a.date));
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: combinedList.length,
                  itemBuilder: (context, index){
                    var data = combinedList[index];
                    //Color Change
                    Color textColor = data is Incomes ? AppColors.IncomeColor : AppColors.ExpenseColor;
                    //For date grouping
                    DateTime currentDate = DateTime.parse(data.date);
                    DateTime? previousDate = index > 0 ? DateTime.parse(combinedList[index-1].date) : null;
                    //For removing time in DateTime
                    DateTime currentDateWithoutTime = DateTime(currentDate.year, currentDate.month, currentDate.day);
                    DateTime? previousDateWithoutTime = previousDate != null
                        ? DateTime(previousDate.year, previousDate.month, previousDate.day)
                        : null;
                    bool isDateChanged = currentDateWithoutTime != previousDateWithoutTime;
                    //For total per day
                    double totalIncome = 0;
                    double totalExpenses = 0;
                    if (data is Incomes) {
                      totalIncome += data.amount;
                    } else {
                      totalExpenses += data.amount;
                    }
                    //For total per Month
                    int currentMonth = currentDate.month;
                    int prevMonth = currentDate.month -1;
                    bool isMonthChanged = currentMonth != prevMonth;
                    monthlyNet = monthlyIncome - monthlyExpense;
                    return Container(
                      child: Column(
                        children: [
                          // if (isMonthChanged) MonthlySummary(monthlyIncome, monthlyExpense, monthlyNet),
                          if (isDateChanged) DailyDates(DateFormat('MM-dd').format(currentDate), totalIncome, totalExpenses),
                          DailyLogs(data.category, data.note, data.amount, textColor),
                        ],
                      )
                    );
                  },
                );
                // return FutureBuilder(
                //   future: db.retrieveExpenses(),
                //   builder: (BuildContext context, expenseSnap) {
                //     if (incomeSnap.connectionState == ConnectionState.waiting){
                //       return const Center(
                //         child: CircularProgressIndicator()
                //       );
                //     }
                //     if (!incomeSnap.hasData){
                //       return const Center(
                //         child: Text(
                //           'No data to show',
                //           style: TextStyle(color: AppColors.TextColor),
                //         ),
                //     );
                //     }
                //     return  ListView.builder(
                //       shrinkWrap: true,
                //       itemCount: ((incomeSnap.data?.length ?? 0) > (expenseSnap.data?.length ?? 0)) ? incomeSnap.data?.length ?? 0 : expenseSnap.data?.length ?? 0,
                //       itemBuilder: (context, index){
                //         return Container(
                //             child: Column(
                //                 children: [
                //                   if(index>=0 && index< incomeSnap.data!.length)
                //                     DailyLogs({incomeSnap.data?[index].date}, {incomeSnap.data?[index].note}, {incomeSnap.data?[index].amount}),
                //                   if(index>=0 && index< expenseSnap.data!.length)
                //                     DailyLogs({expenseSnap.data?[index].date}, {expenseSnap.data?[index].note}, {expenseSnap.data?[index].amount}),
                //           ])
                //         );
                //       },
                //     );
                //   }
                // );

                // return ListView.builder(
                //   shrinkWrap: true,
                //   itemCount: snapshot.data?.length,
                //   itemBuilder: (context, index) {
                //     return Text(
                //       "ID: ${snapshot.data![index].id} "
                //       "Note: ${snapshot.data![index].note}"
                //       "Date: ${snapshot.data![index].date}"
                //       "Amount: ${snapshot.data![index].amount} "
                //       "Category: ${snapshot.data![index].category}",
                //     );
                //   },
                // );
              },
            ),
          ],
        )
      ),
      backgroundColor: AppColors.BGColor,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEntries()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: AppColors.AddButtonColor,
      ),
    );
  }
}


//TODO Header na Month and year
//Baka sa appbar na rin ilalagay
Widget MonthYear = Container(

);

//TODO Try to convert to sticky
Widget MonthlySummary(Income, Expense, Total) => Container(
  padding: EdgeInsets.only(top:10, bottom: 10),
  //margin: EdgeInsets.only(bottom:5),
  decoration: BoxDecoration(
    color: AppColors.PanelBGColor,
    border: Border(
      top: BorderSide(color: AppColors.StrokeColor, width:1),
      bottom: BorderSide(color: AppColors.StrokeColor, width:1),
    )
  ),
  child:  Row(
    //Income / Expense / Total
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      //For Income
      Column(
        children: [
          Text(
            "Income",
            style:TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
                color: AppColors.TextColor
            ),
          ),
          Text(
            Income.toString(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
                color: AppColors.IncomeColor
            ),
          ),
        ]
      ),
      //For Expense
      Column(
          children: [
            Text(
              'Expense',
              style:TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                  color: AppColors.TextColor
              ),
            ),
            Text(
              Expense.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                  color: AppColors.ExpenseColor
              ),
            ),
          ]
      ),
      //For Total
      Column(
          children: [
            Text(
              'Total',
              style:TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                  color: AppColors.TextColor
              ),
            ),
            Text(
              Total.toString(), //retrieve from db
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                  color: AppColors.TextColor
              ),
            ),
          ]
      ),
    ]
  ),
);

Widget DailyDates(date, Income, Expenses) => Container(
  padding: EdgeInsets.only(top:10, bottom: 10),
  decoration: BoxDecoration(
      color: AppColors.PanelBGColor,
      border: Border(
        top: BorderSide(color: AppColors.StrokeColor, width:0),
        bottom: BorderSide(color: AppColors.StrokeColor, width:1),
      )
  ),
  child:  Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
      //Date
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              date.toString(),
            style:TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.TextColor
            )
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
          //Income
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Income.toString(), //retrieve from db
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: AppColors.IncomeColor
                ),
              ),
            ],
          ),
          //Expense
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Expenses.toString(), //retrieve from db
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: AppColors.ExpenseColor
                ),
              ),
            ],
          ),
        ],
      ),

    ],
  ),
);

//Skeleton
//Text Color relative to category
Widget DailyLogs(category, note, amount, textColor) => Container(
    padding: EdgeInsets.only(top:10, bottom: 10),
    decoration: BoxDecoration(
        color: AppColors.PanelBGColor,
        border: Border(
          top: BorderSide(color: AppColors.StrokeColor, width:0),
          bottom: BorderSide(color: AppColors.StrokeColor, width:1),
        )
    ),
  child: Row(
    children: [
      //Category
      Container(
        child: Text(
          category.toString().replaceAll(RegExp('[{}]'), ''),
          style: TextStyle(
            fontSize: 10,
            color: Colors.white54,
          )
        )
      ),
      //Item Name
      Container(
        child: Text(
          note.toString().replaceAll(RegExp('[{}]'), ''),
          style: TextStyle(
            fontSize:16,
            fontWeight: FontWeight.normal,
            color: AppColors.TextColor
          )
        )
      ),
      //Amount
      Container(
        child: Text(
          "₱ "+amount.toString().replaceAll(RegExp('[{}]'), ''),
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: textColor//AppColors.TextColor
          ),
        )
      ),
    ],
  )
);
