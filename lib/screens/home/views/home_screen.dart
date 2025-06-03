import 'dart:math';

import 'package:expense_tracker_bloc_app/screens/analytics/analytics_screen.dart';
import 'package:expense_tracker_bloc_app/screens/home/views/main_screen.dart';
import 'package:flutter/material.dart';

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
          selectedIconTheme: theme.bottomNavigationBarTheme.selectedIconTheme,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
          child: Icon(Icons.add, color: Colors.black),
        ),
      ),
      body: index == 0 ? MainScreen() : AnalyticsScreen(),
    );
  }
}
