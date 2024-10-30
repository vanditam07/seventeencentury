import 'package:flutter/material.dart';

class SideNavBar extends StatelessWidget {
  const SideNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Profile Section with background color
          Container(
            color: const Color(0xFFC4D2FF), // Color only for the top part
            padding: const EdgeInsets.all(20),
            child: const Row(
              children: [
                SizedBox(
                  height: 150,
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.black, size: 30),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'User ID',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 30,
            color: Colors.white,
          ),
          // Rest of the drawer with white background
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(Icons.dashboard, color: Colors.black),
                    title: const Text(
                      'Dashboard',
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/dashboard');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.list, color: Colors.black),
                    title: const Text(
                      'View Forms',
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      // Add action for 'View Forms' here
                    },
                  ),
                ],
              ),
            ),
          ),
          // Logout Button
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.black),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
