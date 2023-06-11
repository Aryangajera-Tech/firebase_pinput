import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_pinput/home_page/cart_page.dart';
import 'package:firebase_pinput/home_page/like_page.dart';
import 'package:firebase_pinput/home_page/resent_home.dart';
import 'package:flutter/material.dart';

var a = cartimage.length;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;

  var page = [Resent_Home(), Cart_Page(), Like_Page()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[index],
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 60.0,
        items: [
          Icon(Icons.home_filled, color: Colors.white, size: 30),
          Icon(Icons.shopping_bag, color: Colors.white, size: 30),
          Icon(Icons.favorite, color: Colors.white, size: 30),
        ],
        color: Colors.black,
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int newIndex) {
          setState(() {
            index = newIndex;
          });
        },
      ),
    );
  }
}
