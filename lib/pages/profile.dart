import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User{
  final int id;
  final String nombre;
  final String apellido;
  final int dni;
  final String email;
  final String contrasena;
  final int rol;
  User(
      {required this.id, required this.nombre, required this.apellido, required this.dni, required this.email, required this.contrasena, required this.rol}
      );

  factory User.fromJson(Map<String, dynamic> json){
    return User(
    id : json["id"],
    nombre : json["nombre"],
    apellido : json["apellido"],
    dni : json["dni"],
    email : json["email"],
    contrasena : json["contraseña"],
    rol :json["rol"],
    );}

}

class Player {
  final int id;
  final String nombre;
  final String apellido;
  final int dni;
  final String nacimiento;
  final String sexo;
  final String estado;
  final String categoria;
  final String club;

  Player(
      {required this.id, required this.nombre, required this.apellido, required this.dni, required this.nacimiento, required this.sexo, required this.estado, required this.categoria, required this.club,});

  factory Player.fromJson(Map<String, dynamic> json){
    return Player(
      id: json["id"],
      nombre: json["nombre"],
      apellido: json["apellido"],
      dni: json["dni"],
      nacimiento: json["nacimiento"],
      sexo: json["sexo"],
      estado: json["estado"],
      categoria: json["categoria"]?.join("")??"NA",
      club: json["club"],
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user = User(id: 0, nombre: '', apellido: '', dni: 0, email: '', contrasena: '', rol: 1);
  Player player = Player(id: 0, nombre: '', apellido: '', dni: 0, estado: '', sexo: '', nacimiento: '', categoria: '', club: '',);
  void getProfile() async {
    print('get profile');
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var response = await http.post(
        Uri.parse('http://10.0.2.2:8000/login'), body: jsonEncode({'dni': 44556778, 'contraseña': 'sf778'}), headers: headers);
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body)["usuario"];
      user = User.fromJson(body);
      var getplayer = await http.get(
        Uri.parse('http://10.0.2.2:8000/jugador?dni=${user.dni}',)
      );
      dynamic playerJson = jsonDecode(getplayer.body)["jugador"];
      player = Player.fromJson(playerJson);
    }else {
      print(response.statusCode);
      throw Exception("Unable to retrieve news");
    }


  }
  void search(){
    setState(() {
      getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    getProfile();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 50,),
          Text("${user.nombre} ${user.apellido}"),
          Text(player.estado.toUpperCase()),
          SizedBox(height: 40,),
          Text(player.club),
          Text(player.categoria),
          OutlinedButton(onPressed: search, child: Text('get')),
        ],
      ),
    );
  }
}
