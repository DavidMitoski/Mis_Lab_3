import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jokes_app/widgets/random_button.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("213221"),
      centerTitle: true,
      actions: const [
        RandomButton(),
      ],
      leading: IconButton(
        icon: const Icon(
          Icons.account_circle,
          size: 30,
        ), // Иконата која сакате да ја додадете
        onPressed: () {
          FirebaseAuth.instance.currentUser != null
              ? Navigator.pushNamed(context, '/profile')
              : Navigator.pushNamed(context, '/login');
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
