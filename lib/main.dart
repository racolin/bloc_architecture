import 'package:flutter/material.dart';
import '../../presentation/app_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pilates Community',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade200,
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: AppRoute().onGenerateRoute,
    );
  }
}
