import 'dart:convert';

import 'package:firebase_pinput/const/product_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class Electronic_Categories extends StatefulWidget {
  const Electronic_Categories({Key? key}) : super(key: key);

  @override
  State<Electronic_Categories> createState() => _Electronic_CategoriesState();
}

class _Electronic_CategoriesState extends State<Electronic_Categories> {
  Future<List<dynamic>>? futureElectronicsProducts;

  Future<List<dynamic>> fetcheElectronicsProducts() async {
    var res = await http
        .get(Uri.https('fakestoreapi.com', '/products/category/electronics'));
    log('Request: ${res.request!.url.toString()}');

    var data = jsonDecode(res.body);
    // if (kDebugMode) {
    //   log('Response: ${data.toString()}');
    // }
    return data;
  }

  @override
  void initState() {
    super.initState();
    futureElectronicsProducts = fetcheElectronicsProducts();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Electronics",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: h,
        child: FutureBuilder<List<dynamic>>(
          future: futureElectronicsProducts,
          builder: (context, data) {
            if (data.hasData) {
              return GridView.builder(
                padding: EdgeInsets.all(15),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }
}
