import 'package:firebase_pinput/categories/electronic.dart';
import 'package:firebase_pinput/categories/jewellery.dart';
import 'package:firebase_pinput/categories/men.dart';
import 'package:firebase_pinput/categories/women.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Men_Categories(),
                    ));
              },
              child: Column(
                children: [
                  Image.asset(
                    'assets/image/men--removebg-preview (1).png',
                    height: 50,
                    width: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      'Men',
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Women_categories(),
                        ));
                  },
                  child: Image.asset(
                    'assets/image/women-removebg-preview.png',
                    height: 50,
                    width: 50,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    'Women',
                    style: TextStyle(fontSize: 15),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 25,
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Electronic_Categories(),
                        ));
                  },
                  child: Image.asset(
                    'assets/image/electronic-removebg-preview.png',
                    height: 50,
                    width: 50,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    'Electronic',
                    style: TextStyle(fontSize: 15),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 25,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Jewellery_categories()));
              },
              child: Column(
                children: [
                  Image.asset(
                    'assets/image/Ring-Jewellery-PNG-Photos.png',
                    height: 50,
                    width: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      'Jewellery',
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Column(
              children: [
                Image.asset(
                  'assets/image/cosmetic.png',
                  height: 50,
                  width: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    'Cosmatic',
                    style: TextStyle(fontSize: 15),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
