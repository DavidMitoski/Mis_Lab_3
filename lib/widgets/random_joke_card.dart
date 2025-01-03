import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/joke_model.dart';

class RandomJokeCard extends StatelessWidget{
  final Joke joke;
  const RandomJokeCard({super.key,required this.joke});

  @override
  Widget build(BuildContext context) {
    return Material(
          child: Container(
            padding: const EdgeInsets.all(38),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.lime,width: 3),
                borderRadius: BorderRadius.circular(40),
                color: Colors.green[300]
            ),
            child:IntrinsicWidth(child:
            Center(child: Column( children: [
                Text(joke.id.toString(),style: const TextStyle(fontSize: 20,fontStyle: FontStyle.italic,color: Colors.white,fontWeight: FontWeight.bold)),
                Text("Type: ${joke.type}",style: const TextStyle(fontSize: 18,color: Colors.white)),
                Text(joke.setup,style: const TextStyle(fontSize: 28,fontStyle: FontStyle.italic,color: Colors.white)),
                Text('- ${joke.punchline}',style: const TextStyle(fontSize: 25,color: Colors.white70)),
            ],)
          ),
            ),
          ),
    );
  }

}