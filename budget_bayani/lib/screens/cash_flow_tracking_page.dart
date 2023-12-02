import 'package:budget_bayani/screens/add_entries.dart';
import 'package:flutter/material.dart';
import 'package:budget_bayani/components/app_color.dart';
import 'package:budget_bayani/components/menu_bar.dart';
import 'package:intl/intl.dart';
import '../db/db_helper.dart';
import '../models/expense.dart';
import '../models/income.dart';
import 'add_entries_2.dart';
class CashFlowPage extends StatefulWidget {
  @override
  State<CashFlowPage> createState() => _CashFlowPage();
}
class _CashFlowPage extends State<CashFlowPage> {
  late DBHelper db;
  double monthlyNet = 0;
  double monthlyIncome = 0;
  double monthlyExpense = 0;
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
      appBar: AppBar(
        title: Text('Cash Flow Tracker'),
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
                double totalIncome = 0;
                double totalExpenses = 0;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: combinedList.length,
                  itemBuilder: (context, index){
                    var data = combinedList[index];
                    print(data);
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
                    if(isDateChanged){
                      totalExpenses = 0;
                      totalIncome = 0;
                    }
                    if(data is Incomes) {
                      totalIncome += data.amount;
                    }
                    if(data is Expenses){
                      totalExpenses += data.amount;
                    }

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
  padding: EdgeInsets.only(top: 10, bottom: 10),
  decoration: BoxDecoration(
    color: AppColors.PanelBGColor,
    border: Border(
      top: BorderSide(color: AppColors.StrokeColor, width: 0),
      bottom: BorderSide(color: AppColors.StrokeColor, width: 1),
    ),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      // Date
      Container(
        margin: EdgeInsets.only(left: 16.0),
        child: Text(
          date.toString(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.TextColor,
          ),
        ),
      ),
      SizedBox(
        width: 200.0, // Adjust the width as needed
      ),
      // Income (centered)
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              Income.toString(), // retrieve from db
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppColors.IncomeColor,
              ),
            ),
          ],
        ),
      ),

      // Expense (aligned to the right)
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            Expenses.toString(), // retrieve from db
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppColors.ExpenseColor,
            ),
          ),
          SizedBox(width: 16.0), // Add some space between income and expense if needed
        ],
      ),
    ],
  ),
);


//Skeleton
//Text Color relative to category
Widget DailyLogs(category, note, amount, textColor) => Container(
  padding: EdgeInsets.only(top: 10, bottom: 10),
  decoration: BoxDecoration(
    color: AppColors.PanelBGColor,
    border: Border(
      top: BorderSide(color: AppColors.StrokeColor, width: 0),
      bottom: BorderSide(color: AppColors.StrokeColor, width: 1),
    ),
  ),
  child: Row(
    children: [
      // Category
      Container(
        margin: EdgeInsets.only(left: 16.0),
        width:50,
        child: Text(
          category.toString().replaceAll(RegExp('[{}]'), ''),
          style: TextStyle(
            fontSize: 10,
            color: Colors.white54,
          ),
        ),
      ),
      SizedBox(width: 20.0),

      // Item Name (expanded)
      Expanded(
        child: Container(
          child: Text(
            note.toString().replaceAll(RegExp('[{}]'), ''),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppColors.TextColor,
            ),
          ),
        ),
      ),

      // Amount (aligned to the right)
      Container(
        margin: EdgeInsets.only(right: 16.0,left:20.0), // Adjust padding as needed
        child: Text(
          "₱ ${amount.toString().replaceAll(RegExp('[{}]'), '')}",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: textColor, // AppColors.TextColor
          ),
        ),
      ),
    ],
  ),
);

