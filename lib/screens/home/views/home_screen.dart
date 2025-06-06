import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker_bloc_app/screens/add_expense/bloc/create_category_bloc/create_category_bloc.dart';
import 'package:expense_tracker_bloc_app/screens/add_expense/bloc/create_expense_bloc/create_expense_bloc.dart';
import 'package:expense_tracker_bloc_app/screens/add_expense/bloc/get_categories_bloc/get_categories_bloc.dart';
import 'package:expense_tracker_bloc_app/screens/add_expense/views/add_expense.dart';
import 'package:expense_tracker_bloc_app/screens/analytics/analytics_screen.dart';
import 'package:expense_tracker_bloc_app/screens/home/bloc/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:expense_tracker_bloc_app/screens/home/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final selectedItem = Colors.white;
  final unselectedItem = Colors.grey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<GetExpensesBloc, GetExpensesState>(
      builder: (context, state) {
        if (state is GetExpensesSuccess) {
          return Scaffold(
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: BottomNavigationBar(
                onTap: (value) {
                  setState(() {
                    index = value;
                  });
                },
                backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
                selectedIconTheme:
                    theme.bottomNavigationBarTheme.selectedIconTheme,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color: index == 0 ? selectedItem : unselectedItem,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.analytics,
                      color: index == 1 ? selectedItem : unselectedItem,
                    ),
                    label: 'Analytics',
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                var newExpense = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (BuildContext context) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create:
                                  (context) =>
                                      CreateCategoryBloc(FirebaseExpenseRepo()),
                            ),
                            BlocProvider(
                              create:
                                  (context) =>
                                      GetCategoriesBloc(FirebaseExpenseRepo())
                                        ..add(GetCategories()),
                            ),
                            BlocProvider(
                              create:
                                  (context) =>
                                      CreateExpenseBloc(FirebaseExpenseRepo()),
                            ),
                          ],
                          child: AddExpense(),
                        ),
                  ),
                );

                if(newExpense != null){
                  setState(() {
                    state.expenses.insert(0, newExpense);
                  });
                }
              },
              shape: CircleBorder(),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.tertiary,
                      theme.colorScheme.secondary,
                    ],
                  ),
                ),
                child: Icon(Icons.add, color: theme.iconTheme.color),
              ),
            ),
            body: index == 0 ? MainScreen(state.expenses) : AnalyticsScreen(),
          );
        } else {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        ;
      },
    );
  }
}
