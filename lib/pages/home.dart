// import 'package:chat_rank/pages/chatPage.dart';
// import 'package:chat_rank/pages/profilePage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  //static const List<Widget> _widgetOptions = <Widget>[
  // final List<Widget> _widgetOptions = <Widget>[
  //   ChatPage(),
  //   ProfilePage(),
  //   // const Text(
  //   //   'Profile Page',
  //   //   style: optionStyle,
  //   // ),
  // ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //resource: https://www.freecodecamp.org/news/build-a-chat-app-ui-with-flutter/
    return const Scaffold(
      body: Text('home page'),
      // body: _widgetOptions.elementAt(_selectedIndex),
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: Colors.greenAccent,
      //   unselectedItemColor: Colors.grey.shade600,
      //   selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      //   unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      //   type: BottomNavigationBarType.fixed,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.message),
      //       label: "Chats",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_box),
      //       label: "Profile",
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      // ),
    );
  }
}
