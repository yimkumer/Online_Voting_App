import 'package:flutter/material.dart';
import 'package:online_voting_app/components/admin%20page/admin_culturalsecretary/admin_culturalsecretary.dart';
import 'package:online_voting_app/components/admin%20page/admin_president/admin_president.dart';
import 'package:online_voting_app/components/admin%20page/admin_sportsecretary/admin_sportsecretary.dart';
import 'package:online_voting_app/components/admin%20page/admin_vicepresident/admin_vicepresident.dart';
import '../login page/login.dart';
// Import the new page

class Admin extends StatelessWidget {
  const Admin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff030034),
        title: const Text(
          '-- Admin Page --',
          style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (String result) {
              if (result == 'logout') {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'logout',
                child: ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text('Logout', style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff030034),
              Color(0xFF040040),
              Color(0xFF06005D),
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(16),
              itemCount: 4, // Number of tiles
              itemBuilder: (context, index) {
                return Container(
                  width: constraints.maxWidth -
                      35, // Full screen width minus padding
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: MenuCard(
                    title: _getTitle(index),
                    description: _getDescription(index),
                    onTap: () => _navigateToPage(context, index),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return '--- President ---';
      case 1:
        return '--- Vice President ---';
      case 2:
        return '--- Sports Secretary ---';
      case 3:
        return '--- Cultural Secretary ---';
      default:
        return '';
    }
  }

  String _getDescription(int index) {
    switch (index) {
      case 0:
        return 'Admin Functions for President Candidates :-\n\n'
            '1. View all the current contesting candidates.\n\n'
            '2. Add new candidates (Name, Department, and Year details required).\n\n'
            '3. Delete any contesting candidates if they violate/disqualify themselves for the post of President.';
      case 1:
        return 'Admin Functions for Vice President Candidates :-\n\n'
            '1. View all the current contesting candidates.\n\n'
            '2. Add new candidates (Name, Department, and Year details required).\n\n'
            '3. Delete any contesting candidates if they violate/disqualify themselves for the post of Vice President.';
      case 2:
        return 'Admin Functions for Sports Secretary Candidates :-\n\n'
            '1. View all the current contesting candidates.\n\n'
            '2. Add new candidates (Name, Department, and Year details required).\n\n'
            '3. Delete any contesting candidates if they violate/disqualify themselves for the post of Sports Secretary.';
      case 3:
        return 'Admin Functions for Cultural Secretary Candidates :-\n\n'
            '1. View all the current contesting candidates.\n\n'
            '2. Add new candidates (Name, Department, and Year details required).\n\n'
            '3. Delete any contesting candidates if they violate/disqualify themselves for the post of Cultural Secretary.';
      default:
        return '';
    }
  }

  void _navigateToPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Navigate to President page
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AdminPresident()),
        );
        break;
      case 1:
        // Navigate to Vice President page
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AdminVicepresident()),
        );
        break;
      case 2:
        // Navigate to Sports Secretary page
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AdminSportsecretary()),
        );
        break;
      case 3:
        // Navigate to Cultural Secretary page
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => const AdminCulturalsecretary()),
        );
        break;
      default:
        break;
    }
  }
}

class MenuCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const MenuCard({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0XFF168AE0),
                    Color(0XFF5D61C3),
                    Color(0XFFB8299B)
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/logo.png',
                          height: constraints.maxHeight * 0.37),
                      FittedBox(
                        child: Text(
                          title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 28),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
