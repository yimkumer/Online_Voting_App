import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Voter extends StatelessWidget {
  const Voter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voter Page'),
      ),
      body: const Center(
        child: Text('This is the Page'),
      ),
    );
  }
}
