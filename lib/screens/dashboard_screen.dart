import 'package:flutter/material.dart';
import '../widgets/side_nav_bar.dart';
import 'form_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideNavBar(), // Reusable navigation bar
      appBar: AppBar(
        title: const Text('Manage Your Google Forms'),
      ),
      body: const FormScreen(), // Display form screen as body content
    );
  }
}
