import 'package:flutter/material.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({required this.currentIndex ,super.key});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {

    List<String> listRoute = [
      "/", "/myBook", "/myAccount"
    ];

    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: Colors.white,
      elevation: 2,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Trang chủ",
          activeIcon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_outlined),
          label: "Tủ sách",
          activeIcon: Icon(Icons.menu_book),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: "Tài khoản",
          activeIcon: Icon(Icons.account_circle),
        ),
      ],
      onTap: (index){
        if(index != currentIndex) Navigator.of(context).pushNamedAndRemoveUntil(listRoute[index], (route) => false);

        // if(index != currentIndex) Navigator.of(context).pushNamed(listRoute[index]);
      },
    );
  }
}
