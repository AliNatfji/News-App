import 'package:flutter/cupertino.dart';

class SettingsScreen extends StatelessWidget {

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Sports Screen',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,

        ),
      ),

    );
  }
}