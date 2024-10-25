import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/screens/animated_button.dart';
import 'package:loginapp/screens/cutsom_input.dart'; // Adjust the import based on your actual file structure

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance
  final TextEditingController _userIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AnimationController? _controller;
  Animation<double>? _animationBlur;
  Animation<double>? _animationFade;
  Animation<double>? _animationSize;

  // Hover state
  bool isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animationBlur = Tween<double>(
      begin: 50,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.ease,
      ),
    );

    _animationFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOutQuint,
      ),
    );

    _animationSize = Tween<double>(
      begin: 0,
      end: 500,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.decelerate,
      ),
    );

    _controller?.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _userIDController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginUser() async {
    final String email =
        '${_userIDController.text.trim()}@gmail.com'; // Create email from user ID
    final String password = _passwordController.text.trim();

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigate to home screen upon successful login
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found with that email.';
          break;
        case 'wrong-password':
          message = 'Incorrect password.';
          break;
        default:
          message = 'Login failed: ${e.message}';
      }
      _showErrorDialog(message);
    } catch (e) {
      _showErrorDialog('An unexpected error occurred: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Login Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "images/fundo.jpg"), // Use your actual background image
            fit: BoxFit.cover,
          ),
        ),
        height:
            MediaQuery.of(context).size.height, // Cover entire screen height
        child: Center(
          // Center the entire content
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _animationSize!,
                    builder: (context, widget) {
                      return MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            isHovering = true; // Set hover state
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            isHovering = false; // Reset hover state
                          });
                        },
                        child: Transform.scale(
                          scale: isHovering ? 1.05 : 1.0, // Scale up on hover
                          child: Container(
                            width: _animationSize?.value,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isHovering
                                  ? Colors.white70
                                  : Colors.white, // Change color on hover
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: isHovering
                                      ? Colors.pink.withOpacity(0.5)
                                      : Colors.grey,
                                  blurRadius: isHovering
                                      ? 30
                                      : 20, // Increase blur radius on hover
                                  spreadRadius: isHovering ? 3 : 2,
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                CustomInput(
                                  controller: _userIDController,
                                  hint: 'User ID',
                                  obscure: false,
                                  icon: const Icon(Icons.person),
                                ),
                                const SizedBox(height: 20), // Add spacing
                                CustomInput(
                                  controller: _passwordController,
                                  hint: 'Password',
                                  obscure: true,
                                  icon: const Icon(Icons.lock),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  MouseRegion(
                    onEnter: (_) {
                      setState(() {
                        // Implement hover effect for button if needed
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        // Reset hover effect
                      });
                    },
                    child: AnimatedButton(
                      controller:
                          _controller!, // Ensure the controller is passed here
                      onPressed: _loginUser, // Pass the login function
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeTransition(
                    opacity: _animationFade!,
                    child: const Text(
                      "Forgot my password",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 100, 127, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
