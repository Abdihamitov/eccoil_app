import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const EcoCoilApp());
}

class EcoCoilApp extends StatelessWidget {
  const EcoCoilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoCoil',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const DashboardScreen(),
    );
  }
}
