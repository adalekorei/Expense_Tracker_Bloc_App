import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker_bloc_app/screens/home/bloc/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:expense_tracker_bloc_app/screens/home/views/home_screen.dart';
import 'package:expense_tracker_bloc_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense tracker',
      theme: theme,
      home: BlocProvider(
        create: (context) => GetExpensesBloc(FirebaseExpenseRepo())..add(GetExpenses()),
        child: HomeScreen(),
      ),
    );
  }
}
