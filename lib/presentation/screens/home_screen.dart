
import 'package:firebase_login_tuan2/logic/authrepository.dart';
import 'package:firebase_login_tuan2/presentation/pages/account_page.dart';
import 'package:firebase_login_tuan2/presentation/pages/home_page.dart';
import 'package:firebase_login_tuan2/presentation/pages/login_page.dart';
import 'package:firebase_login_tuan2/presentation/screens/account_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final AuthRepository _authRepository = AuthRepository();
  int indexCurrent = 0;
  List screens = [
    const HomePage(),
    Container(child: Text('Message'),),
    AccountScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[indexCurrent],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexCurrent,
        onTap: (index) {
          setState (() => indexCurrent = index);
        },
        backgroundColor: Colors.blueGrey,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.messenger),
              label: 'Message'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile'
          )
        ],
      ),
    );
  }
}
