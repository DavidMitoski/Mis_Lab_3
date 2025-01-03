import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String text;

  const Header({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child:Center(child:
      Text(text,style: const TextStyle(fontSize: 35,fontWeight: FontWeight.bold,decoration: TextDecoration.none))
      ),
    );
  }
}
