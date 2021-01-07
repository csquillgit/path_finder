import 'package:flutter/material.dart';

class MyMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            print("Map Route");
          },
          child: Text('Test'),
        ),
      ),
    );
  }
}
