import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RandomButton extends StatelessWidget {
  const RandomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: (){
          Navigator.pushNamed(context, '/random_joke');
        },
        child: const Text(
          'Random',
          style: TextStyle(color: Colors.black54, fontSize: 13.0),
        ),
      ),
    );
  }
}
