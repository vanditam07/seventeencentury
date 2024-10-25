import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart'; // Import your Firebase options
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart'; // Import dashboard screen
import 'screens/form_screen.dart'; // Import form screen
import 'screens/create_button_screen.dart'; // Import create button screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the options specified in firebase_options.dart
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Forms Manager', // Updated title
      theme: ThemeData(
        primarySwatch: Colors.blue, // Set a default primary color
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login', // Start with the login screen
      routes: {
        '/login': (context) => const LoginScreen(), // Login screen route
        '/home': (context) => HomeScreen(), // Home screen route
        '/dashboard': (context) =>
            const DashboardScreen(), // Dashboard screen route
        '/form': (context) => const FormScreen(), // Form screen route
        '/create_button': (context) =>
            const CreateButtonScreen(), // Create button screen route
      },
    );
  }
}
