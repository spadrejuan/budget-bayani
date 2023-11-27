import 'package:flutter/material.dart';

void main() {
  runApp(const LandingPage());
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        drawer: NavigationDrawer(children: [],),
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}

