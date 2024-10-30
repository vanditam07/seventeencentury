import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Import the Flutter Toast package
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class EditButtonScreen extends StatefulWidget {
  final String initialLink;
  final String initialName;

  const EditButtonScreen({
    super.key,
    required this.initialLink,
    required this.initialName,
  });

  @override
  _EditButtonScreenState createState() => _EditButtonScreenState();
}

class _EditButtonScreenState extends State<EditButtonScreen> {
  late TextEditingController _linkController;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _linkController = TextEditingController(text: widget.initialLink);
    _nameController = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _linkController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _saveForm() {
    // Validate and save the form details
    if (_linkController.text.isNotEmpty && _nameController.text.isNotEmpty) {
      // Pop the values back to the previous screen
      Navigator.pop(context, {
        'link': _linkController.text,
        'name': _nameController.text,
      });

      // Show a toast for successful editing
      Fluttertoast.showToast(
        msg: "Form button edited successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      // Show a toast for empty fields
      Fluttertoast.showToast(
        msg: "Please fill out all fields",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Button',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Enter Google Form Link',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _linkController,
              label: 'Form Link',
            ),
            const SizedBox(height: 20),
            const Text(
              'Enter Button Name',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _nameController,
              label: 'Button Name',
            ),
            const SizedBox(height: 30),
            Center(
              child: CustomButton(
                text: 'Save',
                onPressed: _saveForm,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
