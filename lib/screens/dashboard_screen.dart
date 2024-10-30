import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import '../widgets/custom_app_bar.dart';
import '../widgets/side_nav_bar.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Map<String, String>> _formItems = [];
  String currentDate = 'Loading date...';

  @override
  void initState() {
    super.initState();
    _loadFormItems();
    _fetchCurrentISTDate();
  }

  Future<void> _fetchCurrentISTDate() async {
    try {
      // Initialize timezone data
      tz_data.initializeTimeZones();

      // Fetch UTC time from NTP
      DateTime currentTimeUTC = await NTP.now();

      // Set timezone to Asia/Kolkata
      final indiaTimeZone = tz.getLocation('Asia/Kolkata');

      // Convert the UTC time to IST
      final currentTimeInIST =
          tz.TZDateTime.from(currentTimeUTC, indiaTimeZone);

      // Format the date to show only the date part in IST
      setState(() {
        currentDate = DateFormat('dd MMM, yyyy').format(currentTimeInIST);
      });
    } catch (e) {
      setState(() {
        currentDate = 'Unable to load date';
      });
    }
  }

  Future<void> _loadFormItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedData = prefs.getString('formItems');
    if (savedData != null) {
      setState(() {
        _formItems = List<Map<String, String>>.from(
          json.decode(savedData).map((item) => Map<String, String>.from(item)),
        );
      });
    }
  }

  Future<void> _saveFormItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(_formItems);
    await prefs.setString('formItems', encodedData);
  }

  void _addFormItem(Map<String, String> newForm) {
    setState(() {
      _formItems.add(newForm);
    });
    _saveFormItems();
  }

  void _deleteFormItem(int index) {
    setState(() {
      _formItems.removeAt(index);
    });
    _saveFormItems();
  }

  void _editFormItem(int index, String newLink, String newName) {
    setState(() {
      _formItems[index] = {'link': newLink, 'name': newName};
    });
    _saveFormItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideNavBar(),
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              currentDate,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _formItems.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      _buildFormItem(context, index),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/create_button');
          if (result != null && result is Map<String, String>) {
            _addFormItem(result);
          }
        },
        backgroundColor: const Color(0xFFC4D2FF),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFormItem(BuildContext context, int index) {
    final formItem = _formItems[index];

    return Container(
      width: 370,
      height: 120,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFE7EDFF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.white,
            child: Text(
              '${index + 1}',
              style: const TextStyle(color: Colors.black),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Open Link'),
                    content: const Text(
                        'Would you like to open this Google Form link in your browser?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop(); // Close the dialog

                          final String? urlString = formItem['link'];
                          if (urlString != null &&
                              (urlString.startsWith('http://') ||
                                  urlString.startsWith('https://'))) {
                            final Uri url = Uri.parse(urlString);

                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: "Could not open the link",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.redAccent,
                                textColor: Colors.white,
                              );
                            }
                          } else {
                            Fluttertoast.showToast(
                              msg: "Invalid Link! Please edit the link",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.white,
                            );
                          }
                        },
                        child: const Text('Open Link'),
                      ),
                    ],
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC4D2FF),
              fixedSize: const Size(168, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              formItem['name'] ?? 'Google Form',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.grey[600]),
            onSelected: (value) {
              if (value == 'edit') {
                _showEditDialog(context, index);
              } else if (value == 'delete') {
                _showDeleteConfirmation(context, index);
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, int index) {
    final formItem = _formItems[index];

    Navigator.pushNamed(
      context,
      '/edit_button',
      arguments: {
        'link': formItem['link'],
        'name': formItem['name'],
        'index': index, // Pass the index to identify which item to edit
      },
    ).then((result) {
      if (result != null && result is Map<String, String>) {
        _editFormItem(
            index, result['link']!, result['name']!); // Update the form item
      }
    });
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Form'),
          content: const Text('Are you sure you want to delete this form?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteFormItem(index);
                Navigator.of(context).pop();
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
