import 'dart:convert';

import 'package:firebase_pinput/const/product_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class Women_categories extends StatefulWidget {
  const Women_categories({Key? key}) : super(key: key);

  @override
  State<Women_categories> createState() => _Women_categoriesState();
}

class _Women_categoriesState extends State<Women_categories> {
  Future<List<dynamic>>? futureWomenProducts;

  Future<List<dynamic>> fetcheWomenProducts() async {
    var res = await http.get(
        Uri.parse("https://fakestoreapi.com/products/category/women's%20clothing"));
        // Uri.https("fakestoreapi.com', '/products/category/women's clothing"));
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
    futureWomenProducts = fetcheWomenProducts();
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
          "Women",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: h,
        child: FutureBuilder<List<dynamic>>(
          future: futureWomenProducts,
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
