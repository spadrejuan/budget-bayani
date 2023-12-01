import 'package:budget_bayani/screens/budget_planner.dart';
import 'package:budget_bayani/screens/cash_flow_tracking_page.dart';
import 'package:budget_bayani/screens/financial_goals.dart';
import 'package:flutter/material.dart';
import '../screens/landing_page.dart';
import 'package:budget_bayani/components/AppColor.dart';
class SideMenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
    backgroundColor: AppColors.StrokeColor,
    child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        )
    ),
  );
  }

  Widget buildHeader(BuildContext context) => Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
    decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.Stroke2Color, width:2),
        )
    ),
      child: IconButton(
            icon: Image.asset('assets/images/logo.png'),
            iconSize: 200,
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LandingPage(),
              ));
            }
      ),
  );

  Widget buildMenuItems(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            title: const Text('Financial Goals'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => FinancialGoals(),
              ));
            }
          ),
          ListTile(
            title: const Text('Cash Flow Tracking'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => CashFlowPage(),
                ));
              }
          ),
          ListTile(
            title: const Text('Budget Planner'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => BudgetPlanner(),
                ));
              }
          ),
        ]
    ),
  );
}