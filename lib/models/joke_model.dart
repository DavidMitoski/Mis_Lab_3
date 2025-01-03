class Joke {
  int id;
  String type;
  String setup;
  String punchline;

  Joke({required this.id,required this.type,required this.setup,required this.punchline});

  Joke.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        type = data['type'],
        setup = data['setup'],
        punchline=data['punchline'];

  Map<String, dynamic> toJson() => {'id' : id, 'type' : type, 'setup' : setup, 'punchline' : punchline};

}