import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Forms'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildFormButton(context),
          SizedBox(height: 20),
          _buildFormButton(context),
          SizedBox(height: 20),
          _buildFormButton(context),
        ],
      ),
    );
  }

  Widget _buildFormButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the form
          },
          child: Text('Google form'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlueAccent,
          ),
        ),
      ),
    );
  }
}
