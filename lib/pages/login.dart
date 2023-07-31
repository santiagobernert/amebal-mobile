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
      widget.callback(usernameController.text, passwordController.text);
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
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.sports_basketball),
            const SizedBox(height: 30,),
            const Text("Login"),
            TextField(
              controller: usernameController,
              enableSuggestions: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: "DNI",
              ),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: passwordController,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.password),
                labelText: "Contraseña",
              ),
            ),
            const SizedBox(height: 10,),
            OutlinedButton(
              onPressed: onclick,
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.lightBlue),
                foregroundColor: MaterialStatePropertyAll(Colors.white),
              ),
              child: const Text("Log in")),
          ],
        ),
      ),
    );
  }
}
