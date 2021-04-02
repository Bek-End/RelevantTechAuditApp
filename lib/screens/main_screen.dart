import 'package:flutter/material.dart';
import 'package:tech_audit_app/constants/constants.dart';
import 'package:tech_audit_app/screens/error_screen.dart';
import 'package:tech_audit_app/screens/tabs/add_screen.dart';
import 'package:tech_audit_app/screens/tabs/cabinet_screen.dart';
import 'package:tech_audit_app/screens/tabs/map_screen.dart';
import 'package:tech_audit_app/screens/tabs/settings_screen.dart';

class MainScreen extends StatefulWidget {
  static final routeName = "/main";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedPage = 0;
  List<Widget> pageList = List<Widget>();

  @override
  void initState() {
    super.initState();
    pageList.add(MapScreen());
    pageList.add(CabinetScreen());
    pageList.add(AddScreen());
    pageList.add(SettingsScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ТехАудит"),
          centerTitle: true,
        ),
        body: IndexedStack(
          index: _selectedPage,
          children: pageList,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          showSelectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 10,
          selectedItemColor: ProjectColor.darkGrey,
          unselectedItemColor: ProjectColor.grey,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.map_rounded),
                icon: Icon(Icons.map_outlined),
                label: "Карта"),
            BottomNavigationBarItem(
                icon: Icon(Icons.business_outlined),
                activeIcon: Icon(Icons.business_rounded),
                label: "Кабинеты"),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box_outlined),
                activeIcon: Icon(Icons.add_box_rounded),
                label: "Добавить"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings_rounded),
                label: "Настройки")
          ],
        ));
  }

  void _onItemTapped(int index) async {
    setState(() {
      _selectedPage = index;
    });
  }
}
