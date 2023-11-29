import 'package:budget_bayani/screens/financial_goals.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../screens/landing_page.dart';
class SideMenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                  builder: (context) => LandingPage(),
                ));
              }
          ),
          ListTile(
            title: const Text('Budget Planner'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LandingPage(),
                ));
              }
          ),
        ]
    ),
  );
}