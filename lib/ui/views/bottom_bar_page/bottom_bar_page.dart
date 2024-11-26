import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_app/ui/views/basket_page.dart';
import 'package:product_app/ui/views/home_page.dart';

class BottomBarPage extends StatefulWidget {
  const BottomBarPage({super.key});

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  int selectedIndex = 0;

  List<Widget> pageList = [
    const HomePage(),
    const BasketPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          elevation: 8,
          items: [
            BottomNavigationBarItem(
              icon: selectedIndex == 0
                  ? const Icon(Icons.home)
                  : const Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: selectedIndex == 1
                  ? const Icon(CupertinoIcons.cart_fill)
                  : const Icon(CupertinoIcons.cart),
              label: 'Cart',
            ),
          ],
          currentIndex: selectedIndex,
          onTap: (indexs) {
            setState(() {
              selectedIndex = indexs;
            });
          },
        ),
      ),
    );
  }
}
