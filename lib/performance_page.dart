import 'package:flutter/material.dart';

class PerformancePage extends StatefulWidget {
  @override
  _PerformancePageState createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'images/default_performance_page.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
