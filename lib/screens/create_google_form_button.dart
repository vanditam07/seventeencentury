import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginapp/widgets/custom_app_bar.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class CreateButtonScreen extends StatelessWidget {
  const CreateButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController linkController = TextEditingController();
    final TextEditingController nameController = TextEditingController();

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create Button',
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
              controller: linkController,
              label: 'Form Link',
            ),
            const SizedBox(height: 20),
            const Text(
              'Enter Button Name',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: nameController,
              label: 'Button Name',
            ),
            const SizedBox(height: 30),
            Center(
              child: CustomButton(
                onPressed: () {
                  if (linkController.text.isEmpty ||
                      nameController.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: "Please fill out all fields",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.redAccent,
                      textColor: Colors.white,
                    );
                    return;
                  }

                  Navigator.pop(context, {
                    'link': linkController.text,
                    'name': nameController.text,
                  });

                  Fluttertoast.showToast(
                    msg: "Form button created successfully!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                  );
                },
                text: 'Create',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
