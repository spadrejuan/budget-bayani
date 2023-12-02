import 'package:budget_bayani/components/menu_bar.dart';
import 'package:budget_bayani/screens/landing_page_income.dart';
import 'package:flutter/material.dart';
import 'package:budget_bayani/components/app_color.dart';
import 'package:pie_chart/pie_chart.dart';

import '../db/db_helper.dart';

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
  late DBHelper db;
  @override
  void initState(){
    super.initState();
    db = DBHelper();
    db.initDB().whenComplete(() async{
      setState((){});
    });
  }
  // Map<String, double> mapData= {};
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
            IncomeExpenseSelector(context),
            //Piechart
            FutureBuilder(
                future: db.retrieveExpenses(),
                builder: (BuildContext context, snapshot){
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
                  Map<String, double> data = {};
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index){
                      String category = snapshot.data![index].category;
                      double amount = snapshot.data![index].amount.toDouble();
                      data.update(category, (existingValue) => existingValue + amount, ifAbsent: () => amount);

                      return Container (
                        child: (snapshot.data?.length != null && index == snapshot.data!.length -1) ?
                        PieChart(
                          dataMap: data,
                          chartValuesOptions: ChartValuesOptions(
                              showChartValues: false
                          ),
                          // legendOptions: LegendOptions(
                          //   showLegends: false,
                          // ),
                        ) :SizedBox()
                      );
                    }
                  );
                }
            ),
            //Categories

            // CategoryContainer
          ]
        ),
      )
    );
  }
}

//TODO Clean Up
//TODO Income/Expense Highlight when focused
Widget IncomeExpenseSelector(context) => Container (
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LandingPage2()),
              );
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
      Container(
        margin: EdgeInsets.symmetric(vertical: 5), // Add top and bottom margin
        child: Row(
          children: [
            Container(
              width: 40, // Adjust the width as needed
              height: 20, // Adjust the height as needed
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
              ),
            ),
            SizedBox(width: 10), // Add some spacing between the box and the text
            Text('Apple'),
            Spacer(), // Takes up all available space between 'Apple' and the price
            Padding(
              padding: EdgeInsets.only(right: 10), // Adjust the right padding as needed
              child: Text('\$2.99'), // Replace this with your actual price
            ),
          ],
        ),
      ),
      Container(
        height: 1, // Adjust the thickness of the line as needed
        color: Color(0xFF273F4B), // Use the specified color
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 5), // Add top and bottom margin
        child: Row(
          children: [
            Container(
              width: 40,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.green, // Example color for other fruits
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(width: 10),
            Text('Banana'),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text('\$1.99'),
            ),
          ],
        ),
      ),
      Container(
        height: 1,
        color: Color(0xFF273F4B),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 5), // Add top and bottom margin
        child: Row(
          children: [
            Container(
              width: 40,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.orange, // Example color for other fruits
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(width: 10),
            Text('Orange'),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text('\$0.99'),
            ),
          ],
        ),
      ),
      Container(
        height: 1,
        color: Color(0xFF273F4B),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 5), // Add top and bottom margin
        child: Row(
          children: [
            Container(
              width: 40,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.purple, // Example color for other fruits
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(width: 10),
            Text('Grapes'),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text('\$3.49'),
            ),
          ],
        ),
      ),
      Container(
        height: 1,
        color: Color(0xFF273F4B),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 5), // Add top and bottom margin
        child: Row(
          children: [
            Container(
              width: 40,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.yellow, // Example color for other fruits
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(width: 10),
            Text('Pineapple'),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text('\$4.99'),
            ),
          ],
        ),
      ),
      Container(
        height: 1,
        color: Color(0xFF273F4B),
      ),
      // Add more fruit rows as needed
      // ...
    ],
  ),

);

//TODO Category Builder
Widget CategoryBuilder = Container();

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
    chartRadius: MediaQuery.of(context).size.width / 3,
    legendOptions: LegendOptions(
      showLegends: false,
    ),
    chartValuesOptions: ChartValuesOptions(
        showChartValues: false
    ),
  ),
);
