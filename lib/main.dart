import 'package:amebal/pages/fixture.dart';
import 'package:amebal/pages/home.dart';
import 'package:amebal/pages/profile.dart';
import 'package:amebal/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:amebal/widgets/bottom_nav_bar.dart';
import 'package:amebal/themes/light.dart';
import 'package:amebal/themes/dark.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ThemeMode currentTheme = ThemeMode.system;
  List<Widget> pages = const[Home(), Fixture(), Home(), Home(), Profile()];
  int pageIndex = 1;

  void click(int index){
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amebal',
      theme: light,
      darkTheme: dark,
      themeMode: currentTheme,
      home: Scaffold(
        appBar: CustomAppBar(toggle: toggleTheme, currentTheme: currentTheme),
        body: pages[pageIndex],
        bottomNavigationBar: BottomNavBar(pageIndex: pageIndex, onClicked: click,),
      ),
    );
  }


  void toggleTheme(){
    setState(() {
      currentTheme = currentTheme == ThemeMode.dark? ThemeMode.light : ThemeMode.dark;
    });
  }

}
