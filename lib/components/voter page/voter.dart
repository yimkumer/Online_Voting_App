import 'package:flutter/material.dart';
import '../login page/login.dart';
import 'CulturalSecretary/CulturalSecretary.dart';
import 'SportSecretary/SportSecretary.dart';
import 'president/President.dart';
import 'vicepresident/Vicepresident.dart';

class Voter extends StatelessWidget {
  const Voter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff030034),
        title: const Text(
          '-- Cast Your Votes --',
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
                final description = _getDescription(index);
                return Container(
                  width: constraints.maxWidth -
                      35, // Full screen width minus padding
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: MenuCard(
                    title: _getTitle(index),
                    role: description['Role']!,
                    importance: description['Importance']!,
                    page: _getPage(index),
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

  Map<String, String> _getDescription(int index) {
    switch (index) {
      case 0:
        return {
          'Role':
              'Role: The President is the leader and chief representative of the student council. They oversee the council’s operations, chair meetings, and coordinate with the administration and other student organizations. The President is responsible for setting the vision and agenda for the council, ensuring that the team works effectively towards its goals.',
          'Importance':
              'Importance: The President serves as the main liaison between the students and the administration, advocating for student interests and addressing concerns. They play a crucial role in shaping the direction of student activities and initiatives, fostering a positive and inclusive campus environment.'
        };
      case 1:
        return {
          'Role':
              'Role: The Vice President assists the President in their duties and steps in as acting President if the President is unavailable. They help coordinate council activities, manage subcommittees, and support other council members in their roles. The Vice President often takes on specific projects or areas of responsibility as needed.',
          'Importance':
              "Importance: The Vice President ensures continuity and stability within the council. Their support is vital in executing the council's initiatives and maintaining smooth operations. They also provide additional leadership and help address issues or challenges that arise within the council."
        };
      case 2:
        return {
          'Role':
              'Role: The Sports Secretary is responsible for organizing and promoting sports events and activities on campus. They coordinate with sports teams, manage intramural leagues, and work on enhancing student participation in athletic programs. The Sports Secretary also helps in securing resources and facilities for sports-related events.',
          'Importance':
              'Importance: This role is key to fostering school spirit and encouraging student involvement in sports. The Sports Secretary helps ensure that students have opportunities for physical activity and competitive play, contributing to a vibrant and active campus life.'
        };
      case 3:
        return {
          'Role':
              'Role: The Cultural Secretary oversees cultural and artistic activities on campus. They organize events such as talent shows, cultural festivals, and art exhibitions, and work to promote and celebrate diversity. The Cultural Secretary also collaborates with student groups to support cultural and creative initiatives.',
          'Importance':
              'Importance: This role enriches the campus experience by providing opportunities for students to engage in and appreciate diverse cultural expressions. The Cultural Secretary plays a significant role in creating a dynamic and inclusive campus community, celebrating talents and fostering mutual understanding among students.'
        };
      default:
        return {'Role': '', 'Importance': ''};
    }
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const President();
      case 1:
        return const VicePresident();
      case 2:
        return const SportSecretary();
      case 3:
        return const CulturalSecretary();
      default:
        return const Login();
    }
  }
}

class MenuCard extends StatelessWidget {
  final String title;
  final String role;
  final String importance;
  final Widget page;

  const MenuCard({
    super.key,
    required this.title,
    required this.role,
    required this.importance,
    required this.page,
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
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => page),
              );
            },
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
                        role,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 13),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        importance,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 13),
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
