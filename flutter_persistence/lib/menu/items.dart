import 'package:flutter/material.dart';
import 'package:flutter_persistence/menu/header.dart';
import 'package:flutter_persistence/pages/dogs/search.dart';
import 'package:flutter_persistence/pages/path/read-write-files.dart';
import 'package:flutter_persistence/pages/settings/settings.dart';

class MenuItems extends StatefulWidget {
  @override
  _MenuItems createState() => _MenuItems();
}

class _MenuItems extends State<MenuItems> {
  Drawer getNavDrawer(BuildContext context) {
    DrawerHeader header = appDrawerHeader();

    ListTile getNavItem(IconData icon, String title, String routeName) {
      return ListTile(
        leading: Icon(
          icon,
          color: Colors.lightBlueAccent,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        onTap: () {
          setState(() {
            Navigator.of(context).pushReplacementNamed(routeName);
          });
        },
      );
    }

    var navItems = [
      header,
      getNavItem(Icons.pets, "Dogs", DogsSearchPage.routeName),
      getNavItem(Icons.insert_drive_file, "Files", ReadWriteFilePage.routeName),
      getNavItem(Icons.settings, "Settings", SettingsPage.routeName),
    ];

    ListView listView = ListView(
      padding: EdgeInsets.zero,
      children: navItems,
    );

    return Drawer(
      child: listView,
      elevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return getNavDrawer(context);
  }
}
