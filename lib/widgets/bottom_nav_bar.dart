import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int pageIndex;
  ValueChanged<int> onClicked;

  BottomNavBar({super.key, required this.pageIndex, required this.onClicked});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: widget.pageIndex,
        iconSize: 28,
        selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        type: BottomNavigationBarType.shifting,
        onTap: widget.onClicked,
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