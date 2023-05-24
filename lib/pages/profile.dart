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
  final int peso;
  final int estatura;
  final String mano;
  final String posicion;
  final String sanguineo;
  final String telefono;
  final String provincia;
  final String departamento;
  final String localidad;
  final String domicilio;
  final String obrasocial;
  final String carnet;

  Player(
      {required this.id, required this.nombre, required this.apellido, required this.dni, required this.nacimiento, required this.sexo, required this.estado, required this.categoria, required this.club,
      required this.peso, required this.estatura, required this.mano, required this.posicion, required this.sanguineo, required this.telefono, required this.provincia, required this.departamento,
      required this.localidad, required this.domicilio, required this.obrasocial, required this.carnet});

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
        peso: json["peso"],
        estatura: json["estatura"],
        mano: json["mano"],
        posicion: json["posicion"],
        sanguineo: json["sanguineo"],
        telefono: json["telefono"],
        provincia: json["provincia"],
        departamento: json["departamento"],
        localidad: json["localidad"],
        domicilio: json["domicilio"],
        obrasocial: json["obrasocial"],
        carnet: json["carnet"],
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
  Player player = Player(id: 0, nombre: '', apellido: '', dni: 0, estado: '', sexo: '', nacimiento: '', categoria: '', club: '', peso: 0, estatura: 0, mano: '', posicion: '', sanguineo: '', telefono: '', provincia: '', departamento: '', localidad: '', domicilio: '', obrasocial: '', carnet: '');
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
      throw Exception("Unable to retrieve user");
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
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            indicatorColor: Colors.lightBlueAccent,
            tabs: [
              Tab(text: "Perfil",),
              Tab(text: "Datos",),
              Tab(text: "Carnet",),
              Tab(text: "Archivos",),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 50,),
                  SizedBox(height: 10,),
                  Text("${user.nombre} ${user.apellido}"),
                  Text(player.estado.toUpperCase()),
                  SizedBox(height: 40,),
                  Text(player.club),
                  Text(player.categoria),
                  Text(player.carnet),
                  OutlinedButton(onPressed: search, child: Text('get')),
                ],
              ),
            ),
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Datos del usuario"),
                SizedBox(height: 10,),
                Row(children: [Text("Peso: "), Text("${player.peso}"),],),
                Row(children: [Text("Estatura: "), Text("${player.estatura}"),],),
                Row(children: [Text("Mano hábil: "), Text("${player.mano}"),],),
                Row(children: [Text("Grupo Sanguíneo: "), Text("${player.sanguineo}"),],),
                Row(children: [Text("Teléfono: "), Text("${player.telefono}"),],),
                Row(children: [Text("Provincia: "), Text("${player.provincia}"),],),
                Row(children: [Text("Departamento: "), Text("${player.departamento}"),],),
                Row(children: [Text("Localidad: "), Text("${player.localidad}"),],),
                Row(children: [Text("Domicilio: "), Text("${player.domicilio}"),],),
                Row(children: [Text("Obra Social: "), Text("${player.obrasocial}"),],),
              ],
            ),
          ),
        ),
            Icon(Icons.directions_car, size: 350),
            Icon(Icons.directions_car, size: 350),
          ],
        ),
      ),
    );

  }
}
