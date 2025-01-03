import 'package:flutter/cupertino.dart';
import 'package:jokes_app/models/joke_model.dart';

class JokeProvider extends ChangeNotifier{
  List<Joke> _favorites = [];

  List<Joke> get favorites => _favorites;

  void addFavoriteJoke(Joke joke){
    _favorites.add(joke);
    notifyListeners();
  }
  void removeFavoriteJoke(Joke joke){
    _favorites.removeWhere((item)=> item.id==joke.id);
    notifyListeners();
  }
}