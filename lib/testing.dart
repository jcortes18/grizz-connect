import 'package:flutter/material.dart';


class Testing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Center(child: Text('home')),
    );
  }
}