import 'package:expense_tracker_bloc_app/app.dart';
import 'package:expense_tracker_bloc_app/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

