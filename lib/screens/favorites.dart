import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/joke_model.dart';
import '../providers/joke_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/header.dart';

class FavoritesJokesScreen extends StatefulWidget {
  const FavoritesJokesScreen({super.key});

  @override
  State<FavoritesJokesScreen> createState() => _JokesState();
}

class _JokesState extends State<FavoritesJokesScreen> {
  @override
  Widget build(BuildContext context) {
    final jokeProvider = Provider.of<JokeProvider>(context);
    return Scaffold(
      appBar: AppBarWidget(),
      body: Column(
        children: [
          Header(text: "Favorites Jokes"),
          (jokeProvider.favorites.isEmpty)
              ? const Center(
            child: Text(
              "No favorites..",
              style: TextStyle(fontSize: 16),
            ),
          )
              : Expanded(
            child: ListView.builder(
              itemCount: jokeProvider.favorites.length,
              itemBuilder: (context, index) {
                final item = jokeProvider.favorites[index];
                return ListTile(
                  title: Text(item.setup),
                  subtitle: Text(item.punchline),
                  leading: IconButton(
                    icon: const Icon(Icons.favorite),
                    color: Colors.red, // Црвена боја за срцето
                    onPressed: () {
                      jokeProvider.removeFavoriteJoke(item);
                    },
                  ),
                  trailing: Text("ID: ${item.id}"),
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
