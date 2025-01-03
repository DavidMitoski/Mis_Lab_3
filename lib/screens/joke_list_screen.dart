import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jokes_app/models/joke_model.dart';
import 'package:jokes_app/providers/joke_provider.dart';
import 'package:jokes_app/widgets/custom_app_bar.dart';
import 'package:jokes_app/widgets/bottom_bar.dart';
import 'package:provider/provider.dart';
import '../services/api_services.dart';
import '../widgets/header.dart';

class JokesScreen extends StatefulWidget {
  const JokesScreen({super.key});

  @override
  State<JokesScreen> createState() => _JokesState();
}

class _JokesState extends State<JokesScreen> {
  List<Joke> jokes = [];
  String type = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments as String;
    setState(() {
      type = arguments;
    });
    if (type.isNotEmpty) {
      getAllJokesForTypeApi(type);
    }
  }

  void getAllJokesForTypeApi(String type) async {
    ApiService.getAllJokesForTypeFromAPI(type).then((response) {
      var data = List.from(json.decode(response.body));
      setState(() {
        jokes = data.asMap().entries.map<Joke>((element) {
          return Joke.fromJson(element.value);
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final jokeProvider = Provider.of<JokeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('$type Jokes'),
      ),
      body: jokes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: jokes.length,
        itemBuilder: (context, index) {
          final item = jokes[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(item.setup,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                // child: Text(item.punchline,
                //     style: const TextStyle(
                //         fontSize: 14, color: Colors.green)),
              ),
              leading: IconButton(
                icon: Icon(
                  jokeProvider.favorites
                      .any((tmp) => tmp.id == item.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: jokeProvider.favorites
                      .any((tmp) => tmp.id == item.id)
                      ? Colors.red
                      : null,
                ),
                onPressed: () {
                  if (jokeProvider.favorites
                      .any((tmp) => tmp.id == item.id)) {
                    jokeProvider.removeFavoriteJoke(item);
                  } else {
                    jokeProvider.addFavoriteJoke(item);
                  }
                },
              ),
              trailing: Text("ID: ${item.id}"),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomBarWidget(),
    );
  }
}
