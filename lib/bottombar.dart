import 'package:flutter/material.dart';
import 'package:instgram_nk/screens/add.dart';
import 'package:instgram_nk/screens/fav.dart';
import 'package:instgram_nk/screens/home.dart';
import 'package:instgram_nk/screens/profile.dart';
import 'package:instgram_nk/screens/search.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedIndex = 0;
  List pages = [
    const HomePage(),
    const SearchPage(),
    const AddPage(),
    const FavPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black38,
          currentIndex: selectedIndex,
          onTap: (index) => (setState(() => selectedIndex = index)),
          items: const [
            BottomNavigationBarItem(label: '', icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: '', icon: Icon(Icons.search)),
            BottomNavigationBarItem(
                label: '', icon: Icon(Icons.add_box_outlined)),
            BottomNavigationBarItem(
                label: '', icon: Icon(Icons.favorite_border)),
            BottomNavigationBarItem(
                label: '', icon: Icon(Icons.people_outlined)),
          ]),
    );
  }
}
