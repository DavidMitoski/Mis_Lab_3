import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jokes_app/models/joke_model.dart';
import 'package:jokes_app/widgets/random_joke_card.dart';
import '../services/api_services.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/header.dart';

class RandomJoke extends StatefulWidget{
  const RandomJoke({super.key});

  @override
  State<RandomJoke> createState() => _RandomJokeState();

}
class _RandomJokeState extends State<RandomJoke>{
  Joke joke = Joke(id: 0, type: '', setup: '', punchline: '');
  @override
  void initState() {
    super.initState();
    getRandomJokeFromApi();
  }
  void getRandomJokeFromApi() async {
    ApiService.getRandomJokeFromAPI().then((response) {
      var data =json.decode(response.body);
      setState(() {
        joke=Joke.fromJson(data);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(),
        body:Column(
          children: [
            const Header(text: "Random joke of the day"),
            RandomJokeCard(joke: joke),
          ]
        ),

      bottomNavigationBar: BottomBarWidget(),

    );
  }
}