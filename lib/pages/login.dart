import 'package:amebal/pages/profile.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Function callback;
  Login(this.callback, {Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late User? user;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void onclick(){
    setState(() {
      widget.callback();
    });
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
              onPressed: onclick,
              child: const Text("Log in"))
        ],
      ),
    );
  }
}
