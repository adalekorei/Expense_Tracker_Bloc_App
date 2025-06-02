import 'package:expense_tracker_bloc_app/screens/home/views/home_screen.dart';
import 'package:expense_tracker_bloc_app/theme.dart';
import 'package:flutter/material.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense tracker',
      theme: theme,
      home: HomeScreen(),
    );
  }
}
