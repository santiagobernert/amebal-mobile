import 'package:amebal/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late User? user;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(){
    // if username and password are valid, navigate to Profile
    signIn(usernameController.text, passwordController.text).then((user) => {
      this.user = user,
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()))
    });
    usernameController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(Icons.sports_basketball),
          const SizedBox(height: 30,),
          const Text("Login"),
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person),
              labelText: "Usuario",
            ),
          ),
          const SizedBox(height: 10,),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.password),
              labelText: "Contraseña",
            ),
          ),
          const SizedBox(height: 10,),
          OutlinedButton(
              onPressed: login,
              child: const Text("Log in"))
        ],
      ),
    );
  }
}
