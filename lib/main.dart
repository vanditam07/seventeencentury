import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart'; // Import your Firebase options
import 'screens/edit_google_form_button.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart'; // Import dashboard screen
import 'screens/create_google_form_button.dart'; // Import create button screen

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
      title: 'Google Forms Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFC4D2FF),
        primarySwatch: Colors.blue, // Set a default primary color
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/dashboard',
      routes: {
        '/login': (context) => const LoginScreen(), // Login screen route
        '/dashboard': (context) =>
            const DashboardScreen(), // Dashboard screen route
        '/create_button': (context) =>
            const CreateButtonScreen(), // Create button screen route
        '/edit_button': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;

          if (args is Map<String, String>) {
            return EditButtonScreen(
              initialLink: args['link'] ?? '',
              initialName: args['name'] ?? '',
            );
          } else {
            // Handle the case where args is not passed or is of the wrong type
            return const EditButtonScreen(initialLink: '', initialName: '');
          }
        },
      },
    );
  }
}
