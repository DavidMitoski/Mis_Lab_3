import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jokes_app/providers/user_provider.dart';
import 'package:jokes_app/widgets/custom_app_bar.dart';
import 'package:jokes_app/widgets/header.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
  }

  bool isValidEmail(String email) {
    RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
      caseSensitive: false,
    );

    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final passwordVisibility = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: const AppBarWidget(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Header(text: "Register"),
                  //NAME
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(border: OutlineInputBorder(),
                          focusColor: Colors.green, labelText: "Name", hintText: "Enter Name"),
                    ),
                  ),
                  //EMAIL
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(border: OutlineInputBorder(),
                          focusColor: Colors.green, labelText: "Email", hintText: "Enter Email"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!isValidEmail(value)) {
                          return 'Email not valid!';
                        }
                        return null;
                      },
                    ),
                  ),

                  //PASSWORD
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: passwordVisibility.isObscure,
                      decoration: InputDecoration(focusColor: Colors.green, border: const OutlineInputBorder(),
                        labelText: "Password", hintText: "Enter password",
                        suffixIcon: IconButton(
                          icon: Icon(passwordVisibility.isObscure ? Icons.visibility_off : Icons.visibility),
                          onPressed: () {
                            passwordVisibility.toggleVisibility();
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password should not have less than 6 characters.';
                        }
                        return null;
                      },
                    ),
                  ),

                  //PHONE
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(border: OutlineInputBorder(),
                          focusColor: Colors.green, labelText: "Phone", hintText: "Enter Phone"),
                    ),
                  ),

                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, '/login');
                    }, child: const Text("Already have an account? Sing In!")),
                  ]),

                  Padding(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                    child: Center(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.check_circle_outline_sharp),
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {
                            await AuthService().register(emailController.text, passwordController.text, context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please fill input')),
                            );
                          }
                        },
                        label: const Text('Register'),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

