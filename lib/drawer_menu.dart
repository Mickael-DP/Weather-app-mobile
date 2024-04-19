import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final List<String> cities;
  final Function(String) onTap;

  // Ctor
  const DrawerMenu({super.key, required this.cities, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        menuHeader(),
        Expanded(
          child: ListView.builder(
              itemBuilder: (context, index) => menuItem(cities[index]),
              itemCount: cities.length),
        )
      ],
    ));
  }

  DrawerHeader menuHeader() {
    return const DrawerHeader(
      child: Column(
        children: [
          Icon(
            Icons.location_pin,
            size: 40,
            color: Colors.pink,
          ),
          Text(
            "Mes Villes",
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }

  ListTile menuItem(String s) {
    return ListTile(
        title: Text(
          s,
          style: const TextStyle(fontSize: 24),
        ),
        onTap: () => onTap(s));
  }

}
