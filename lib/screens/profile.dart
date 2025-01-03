import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../widgets/header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           const Header(text: "About Profile"),
           const CircleAvatar(radius: 100,
              backgroundImage: NetworkImage("https://cdn1.iconfinder.com/data/icons/user-pictures/101/malecostume-512.png"),
          ),

          Card(elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person, size: 28, color: Colors.green),
                  const SizedBox(width: 10),
                  Text(AuthService().getUserEmail(),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await AuthService().logout(context);
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.black54, fontSize: 13.0),
            ),
          )
        ],
      ),
    );
  }
}

