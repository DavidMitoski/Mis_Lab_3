import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/joke_provider.dart';

class BottomBarWidget extends StatelessWidget  {

  const BottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final jokeProvider=Provider.of<JokeProvider>(context);
    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
    notchMargin: 6.0,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
    IconButton(
        onPressed: () {
    Navigator.pushNamed(context, '/');
    },
    icon: const Icon(Icons.home),

    ),
      Stack(
        clipBehavior: Clip.none, // Овозможува излегување на елементите надвор од Stack
        children: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                ),
                child: Center(
                  child: Text(
                    jokeProvider.favorites.length.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    ],
    )
    );
  }

}