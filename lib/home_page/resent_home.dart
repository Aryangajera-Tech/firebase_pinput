import 'dart:convert';

import 'package:firebase_pinput/User_login/Sign_in.dart';
import 'package:firebase_pinput/categories/categories.dart';
import 'package:firebase_pinput/const/product_card.dart';
import 'package:firebase_pinput/home_page/cart_page.dart';
import 'package:firebase_pinput/home_page/like_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class Resent_Home extends StatefulWidget {
  const Resent_Home({Key? key}) : super(key: key);

  @override
  State<Resent_Home> createState() => _Resent_HomeState();
}

class _Resent_HomeState extends State<Resent_Home> {
  GlobalKey<ScaffoldState> _drawerpage = GlobalKey<ScaffoldState>();
  Future<List<dynamic>>? futureProduct;

  Future<List<dynamic>> fetchProducts() async {
    var res = await http.get(
        Uri.parse("https://fakestoreapi.com/products"));
        //Uri.https('fakestoreapi.com', '/products'));
    log('Request: ${res.request!.url.toString()}');

    var data = jsonDecode(res.body);
    if (kDebugMode) {
      log('Response: ${data.toString()}');
    }
    return data;
  }

  @override
  void initState() {
    super.initState();
    futureProduct = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
        drawer: Drawer(
          key: _drawerpage,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Account',
                      style: TextStyle(fontSize: 25),
                    ),
                    Icon(Icons.person_add_alt_1)
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Cart_Page(),));
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cart',
                        style: TextStyle(fontSize: 25),
                      ),
                      Icon(
                        Icons.add_shopping_cart_outlined,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Like_Page(),));
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Like',
                        style: TextStyle(fontSize: 25),
                      ),
                      Icon(
                        Icons.favorite_border,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => sign_in(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Logout", style: TextStyle(fontSize: 25)),
                      Icon(Icons.logout),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: w / 7.5,
                          height: h / 15,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.menu_rounded, color: Colors.white),
                            onPressed: () =>
                                _drawerpage.currentState!.openDrawer(),
                          ),
                        ),
                        Container(
                          width: w / 1.55,
                          height: h / 15,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                hintText: 'Search your product',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: w / 7.5,
                          height: h / 15,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                              icon: Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ),
                              onPressed: () {}),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Categories',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Categories(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Product',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: FutureBuilder<List<dynamic>>(
                      future: futureProduct,
                      builder: (context, data) {
                        if (data.hasData) {
                          return GridView.builder(
                            padding: EdgeInsets.all(15),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2 / 3,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 15),
                            itemCount: data.data!.length,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int i) {
                              return ProductCardTile(data: data.data![i]);
                            },
                          );
                        } else if (data.hasError) {
                          return Text("${data.error}");
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ]))));
  }
}
