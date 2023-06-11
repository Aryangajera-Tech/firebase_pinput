import 'package:firebase_pinput/home_page/cart_page.dart';
import 'package:firebase_pinput/home_page/like_page.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:readmore/readmore.dart';


class ProductCardTile extends StatelessWidget {
  final dynamic data;

  const ProductCardTile({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool likedata = true;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          useSafeArea: true,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              actionsPadding: EdgeInsets.zero,
              buttonPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.all(8),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Details'),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close))
                ],
              ),
              content: InteractiveViewer(
                minScale: 0.1,
                maxScale: 1.9,
                child: Column(
                  children: [
                    Image.network(
                      data['image'],
                      height: size.height * 0.5,
                      width: size.width,
                    ),
                    Text(
                      data['title'],
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          '₹',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          data!['price'].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.zero,
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: Image.network(
                  data['image']!,
                  height: size.height,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 2.0),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(right: 5, left: 5, bottom: 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ReadMoreText(
                      data['title'],
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      trimLines: 3,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '₹',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              data!['price'].toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: IconButton(
                            splashColor: Colors.blue,
                            tooltip: 'Add to cart',
                            onPressed: () {
                              cartimage.add(data['image']!);
                              cartname.add(data['title']);
                              cartprice.add(data!['price']);
                            },
                            icon: Icon(Icons.add_shopping_cart_rounded),
                            color: Colors.blue,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            likeimage.add(data['image']!);
                            likename.add(data['title']);
                            likeprice.add(data!['price']);
                          },
                          child: LikeButton(
                            size: 30,
                            circleColor: CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                            bubblesColor: BubblesColor(
                              dotPrimaryColor: Color(0xff33b5e5),
                              dotSecondaryColor: Color(0xff0099cc),
                            ),
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                Icons.favorite,
                                color: isLiked ? Colors.pink : Colors.grey,
                                size: 30,
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
