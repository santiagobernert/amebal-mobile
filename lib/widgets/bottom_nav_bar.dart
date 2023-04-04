import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  late int pageIndex;
  BottomNavBar({super.key, required this.pageIndex});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: widget.pageIndex,
        iconSize: 28,
        selectedItemColor: const Color(0xff155195),
        unselectedItemColor: const Color(0x55555555),
        type: BottomNavigationBarType.shifting,
        onTap: (index) {
          setState(() {
            widget.pageIndex = index;
          });
        },
        items: _navBarItems);
  }
}


const _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.table_rows_outlined),
    activeIcon: Icon(Icons.table_rows_sharp),
    label: 'Posiciones',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.calendar_month_outlined),
    activeIcon: Icon(Icons.calendar_month_sharp),
    label: 'Fixture',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined ),
    activeIcon: Icon(Icons.home_rounded),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.shield_outlined),
    activeIcon: Icon(Icons.shield_rounded),
    label: 'Equipos',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person_outline_rounded),
    activeIcon: Icon(Icons.person_rounded),
    label: 'Perfil',
  ),
];