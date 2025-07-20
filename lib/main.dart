import 'package:flutter/material.dart';
import 'package:movemate/constants/app_colors.dart';
import 'package:movemate/dashboard_wrapper/dashboard_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoveMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      home: const DashboardWrapper(),
    );
  }
}
