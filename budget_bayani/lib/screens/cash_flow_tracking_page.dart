import 'package:budget_bayani/screens/add_entries.dart';
import 'package:flutter/material.dart';
import 'package:budget_bayani/components/AppColor.dart';
import 'package:budget_bayani/components/menu_bar.dart';

//TODO Change back to menu bar
//Di ko alam if kailangan palitan yung process ng pagchange ng page
class CashFlowPage extends StatefulWidget {
  @override
  State<CashFlowPage> createState() => _CashFlowPage();
}
class _CashFlowPage extends State<CashFlowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CashFlowPage'),
        backgroundColor: AppColors.PanelBGColor,

      ),
      drawer: SideMenuBar(),
      body: SingleChildScrollView(
        child: Column (
          //child: Text('This is the CashFlowPage'),
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MonthlySummary,
            DailyDates,
            DailyLogs(0),
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
Widget MonthlySummary = Container(
  padding: EdgeInsets.only(top:10, bottom: 10),
  //margin: EdgeInsets.only(bottom:5),
  decoration: BoxDecoration(
    color: AppColors.PanelBGColor,
    border: Border(
      top: BorderSide(color: AppColors.StrokeColor, width:1),
      bottom: BorderSide(color: AppColors.StrokeColor, width:1),
    )
  ),
  child: const Row(
    //Income / Expense / Total
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      //For Income
      Column(
        children: [
          Text(
            'Income',
            style:TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
                color: AppColors.TextColor
            ),
          ),
          Text(
            '5,000',
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
              '5,000',
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
              '5,000', //retrieve from db
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

Widget DailyDates = Container(
  padding: EdgeInsets.only(top:10, bottom: 10),
  decoration: BoxDecoration(
      color: AppColors.PanelBGColor,
      border: Border(
        top: BorderSide(color: AppColors.StrokeColor, width:0),
        bottom: BorderSide(color: AppColors.StrokeColor, width:1),
      )
  ),
  child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
      //Date
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '15',
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
                '5,000', //retrieve from db
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
                '5,000', //retrieve from db
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

//TODO Compiles DailyLogs
//Di ko pa maisip paano magretrieve from db
Widget DailyLogsContainer = Container ();
//Skeleton
//Text Color relative to category
Widget DailyLogs(number) => Container(
    padding: EdgeInsets.only(top:10, bottom: 10),
    margin: EdgeInsets.only(bottom:5),
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
        child: const Text(
          'categName',
          style: TextStyle(
            fontSize: 10,
            color: Colors.white54,
          )
        )
      ),
      //Item Name
      Container(
        child: Text(
          'Item',
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
          '5,000',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppColors.TextColor
          ),
        )
      ),
    ],
  )
);

Widget AddEntry = Container(

);

