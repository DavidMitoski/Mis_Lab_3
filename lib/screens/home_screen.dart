import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jokes_app/widgets/custom_app_bar.dart';
import 'package:jokes_app/widgets/bottom_bar.dart';
import 'package:jokes_app/providers/joke_provider.dart';
import 'package:provider/provider.dart';
import 'package:jokes_app/services/api_services.dart';
import 'package:jokes_app/models/joke_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> types = [];
  List<Joke> jokes = [];
  String selectedType = "";

  @override
  void initState() {
    super.initState();
    getTypesFromApi();
  }

  void getTypesFromApi() async {
    try {
      final response = await ApiService.getTypesFromAPI();
      var data = List.from(json.decode(response.body));
      setState(() {
        types = List<String>.from(data);
      });
    } catch (e) {
      print('Error loading types: $e');
    }
  }

  void getAllJokesForType(String type) async {
    try {
      final response = await ApiService.getAllJokesForTypeFromAPI(type);
      var data = List.from(json.decode(response.body));
      setState(() {
        jokes = data.map((joke) => Joke.fromJson(joke)).toList();
        selectedType = type; // Set selected type
      });
    } catch (e) {
      print('Error loading jokes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final jokeProvider = Provider.of<JokeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jokes App 213221'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () {
              // Add logic for random joke if needed
            },
          ),
        ],
      ),
      body: selectedType.isEmpty
          ? types.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        itemCount: types.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(
                types[index],
                style: const TextStyle(fontSize: 18),
              ),
              onTap: () {
                getAllJokesForType(types[index]);
              },
            ),
          );
        },
      )
          : Column(
        children: [
          // Header with selected type
          Container(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                '$selectedType Jokes',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          jokes.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                final item = jokes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      item.setup,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        item.punchline,
                        style: const TextStyle(fontSize: 14, color: Colors.green),
                      ),
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
                        if (jokeProvider.favorites.any((tmp) => tmp.id == item.id)) {
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
          ),
        ],
      ),
      bottomNavigationBar: BottomBarWidget(),
    );
  }
}

