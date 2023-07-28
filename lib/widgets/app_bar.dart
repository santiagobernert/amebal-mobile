import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function toggle;
  final ThemeMode currentTheme;
  const CustomAppBar({super.key, required this.toggle, required this.currentTheme});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {

  void action () {
    widget.toggle();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SizedBox(
        width: 40,
        child: Icon(Icons.sports_basketball, color: widget.currentTheme == ThemeMode.dark? Colors.white: Colors.black54,),
      ),
      centerTitle: true,
      elevation: 0,
      actions: [
        IconButton(
            onPressed: action,
            icon: Icon(
                widget.currentTheme == ThemeMode.dark? Icons.dark_mode: Icons.light_mode,
                color: widget.currentTheme == ThemeMode.dark? Colors.white: Colors.black54,
            )
        )
      ],
    );
  }

}
