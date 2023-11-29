import 'package:budget_bayani/components/menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:budget_bayani/components/AppColor.dart';
import 'package:pie_chart/pie_chart.dart';

enum DashboardViews{
  income,
  expenses
}

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => _LandingPageState();
}
//Di ko alam ginagawa ko
class _LandingPageState extends State<LandingPage> {
  late DashboardViews selectedDashboardView;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BGColor,
      drawer: SideMenuBar(),
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: AppColors.PanelBGColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IncomeExpenseSelector,
            PieChartContainer(context),
            CategoryContainer

          ]
        ),
      )
    );
  }
}

//TODO Clean Up
//TODO Income/Expense Highlight when focused
Widget IncomeExpenseSelector = Container (
    padding: EdgeInsets.only(top:15, bottom: 15),
    decoration: BoxDecoration(
        color: AppColors.PanelBGColor,
        border: Border(
          top: BorderSide(color: AppColors.StrokeColor, width:1.5),
          //bottom: BorderSide(color: AppColors.StrokeColor, width:1),
        )
    ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Expanded(
        flex:1,
        child: Center(
          child: InkWell(
            onTap: (){
              //TODO doSomething
            },
            child: const Text(
              'Income',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: AppColors.TextColor,
              )
            )
          )
        )
      ),
      Expanded(
        flex: 1,
        child: InkWell(
          onTap: () {
            //TODO doSomething
          },
          child: const Center(
              child: Text(
              'Expense',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: AppColors.TextColor,
              )
            )
          )
        )
      ),
    ]
  )
);

//TODO Retrieve actual Data
Widget PieChartContainer(context) => Container(
  padding: EdgeInsets.only(top:25, bottom: 25),
  margin: EdgeInsets.only(bottom: 5),
  decoration: BoxDecoration(
      color: AppColors.PanelBGColor,
      border: Border(
        top: BorderSide(color: AppColors.StrokeColor, width:1.5),
        bottom: BorderSide(color: AppColors.StrokeColor, width:1.5),
      )
  ),
  child: PieChart(
    dataMap: {
      'Apples': 10,
      'Bananas': 15,
      'Oranges': 20,
    },
    chartType: ChartType.disc,
    animationDuration: Duration(seconds: 1),
    chartRadius: MediaQuery.of(context).size.width / 2,
    legendOptions: LegendOptions(
      showLegends: false,
    ),
    chartValuesOptions: ChartValuesOptions(
      showChartValues: false
    ),
  ),
);

//TODO Category Compiler
Widget CategoryContainer = Container (
  padding: EdgeInsets.only(top:8, bottom: 8),
  decoration: BoxDecoration(
      color: AppColors.PanelBGColor,
      border: Border(
        top: BorderSide(color: AppColors.StrokeColor, width:1.5),
        bottom: BorderSide(color: AppColors.StrokeColor, width:1.5),
      )
  ),
  child: Column(
    children: [
      Row(
        children: [
          Text('Apple')
        ],
      )
    ],
  )
);

//TODO Category Builder
Widget CategoryBuilder = Container();