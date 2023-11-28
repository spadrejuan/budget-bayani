import 'package:budget_bayani/screens/cash_flow_tracking_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(children: [],),
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to CashFlowPage, pang test lang
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CashFlowPage()),
            );
          },
          child: Text('Cash Flow Logs'),
        ),
      ),
    );
  }
}

