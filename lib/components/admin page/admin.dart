import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Admin extends StatelessWidget {
  const Admin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
      ),
      body: const Center(
        child: Text('This is the Admin Page'),
      ),
    );
  }
}
