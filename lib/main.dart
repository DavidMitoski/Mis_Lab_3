import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:jokes_app/providers/joke_provider.dart';
import 'package:jokes_app/providers/user_provider.dart';
import 'package:jokes_app/screens/favorites.dart';
import 'package:jokes_app/screens/home_screen.dart';
import 'package:jokes_app/screens/joke_list_screen.dart';
import 'package:jokes_app/screens/login.dart';
import 'package:jokes_app/screens/profile.dart';
import 'package:jokes_app/screens/random_joke_screen.dart';
import 'package:jokes_app/screens/register.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final notificationSettings = await FirebaseMessaging.instance.requestPermission(provisional: true);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('Token: $fcmToken');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=>JokeProvider()),
      ChangeNotifierProvider(create: (_)=>UserProvider())
    ],
    child: const MyApp(),
  )  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes App',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) =>const Home(),
        "/jokes":(context)=>const JokesScreen(),
        "/random_joke":(context)=>const RandomJoke(),
        "/favorites":(context)=>const FavoritesJokesScreen(),
        "/login":(context)=>const LoginPage(),
        "/register":(context)=>const RegisterPage(),
        "/profile":(context)=>const ProfilePage(),

      },
    );
  }
}