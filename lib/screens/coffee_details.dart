import 'dart:convert';

import 'package:coffee_cup_ui/data/constants.dart';
import 'package:coffee_cup_ui/data/database.dart';
import 'package:coffee_cup_ui/model/coffee_cup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'cart_screen.dart';

class CoffeeDetailsScreen extends StatefulWidget {
  const CoffeeDetailsScreen({super.key, required this.coffeeCup});
  final CoffeeCup coffeeCup;

  @override
  State<CoffeeDetailsScreen> createState() => _CoffeeDetailsScreenState();
}

class _CoffeeDetailsScreenState extends State<CoffeeDetailsScreen> {
  MyDb myDb = MyDb();
  List<int> selectedExtras = [];
  List<String> selectedExtraImages = [];

  @override
  void initState() {
    myDb.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(141, 193, 208, 1),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 4, child: buildTopDetails()),
            Expanded(flex: 5, child: buildBottomDetails()),
          ],
        ),
      ),
    );
  }

  Widget buildBottomDetails() => Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        decoration: const BoxDecoration(
            color: Color.fromRGBO(244, 249, 250, 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: buildDescription()),
            Expanded(flex: 3, child: buildExtra()),
            Expanded(child: buildButtons()),
          ],
        ),
      );

  Widget buildButtons() => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  await myDb.db!.rawInsert(
                      'INSERT INTO coffeeCarts (image, title, price, extras) VALUES (?, ?, ?, ?)',
                      [
                        widget.coffeeCup.image,
                        widget.coffeeCup.name,
                        widget.coffeeCup.price,
                        jsonEncode(selectedExtraImages),
                      ]).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.white,
                        content: Text(
                          'Product Added to Cart',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        )));
                  });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(95, 163, 182, 1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.coffeeCup.price}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(95, 163, 182, 1),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Center(
                  child: Text(
                    'Order Now',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildExtra() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5, bottom: 10),
            child: Text(
              'Add Extra',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(58, 72, 89, 1)),
            ),
          ),
          Expanded(
              child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 8),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final extra = extras[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectedExtras.contains(index)) {
                            selectedExtras.remove(index);
                            selectedExtraImages.remove(extra.image);
                          } else {
                            selectedExtras.add(index);
                            selectedExtraImages.add(extra.image);
                          }
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: selectedExtras.contains(index)
                              ? const Color.fromRGBO(141, 193, 208, 1)
                              : Colors.white,
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Image.asset(
                                            'assets/${extra.image}'),
                                      ),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            extra.name,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: selectedExtras
                                                        .contains(index)
                                                    ? Colors.white
                                                    : const Color.fromRGBO(
                                                        58, 72, 89, 1)),
                                          ),
                                          Text(
                                            '\$${extra.price}',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: selectedExtras
                                                        .contains(index)
                                                    ? Colors.white
                                                    : const Color.fromRGBO(
                                                        58, 72, 89, 1)),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                            const Positioned(
                                bottom: 8,
                                right: 8,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor:
                                      Color.fromRGBO(95, 163, 182, 1),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                  itemCount: extras.length))
        ],
      );

  Widget buildDescription() => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.coffeeCup.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(58, 72, 89, 1),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      RatingBar.builder(
                          initialRating: widget.coffeeCup.rating,
                          itemCount: 5,
                          itemSize: 18,
                          itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                          onRatingUpdate: (value) {}),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.coffeeCup.rating.toString(),
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey.shade300,
                child: Icon(
                  widget.coffeeCup.favorite
                      ? Icons.favorite
                      : Icons.favorite_outline,
                  size: 18,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          const Expanded(
              child: Text(
            'Ice cream is a frozen dessert typically made from milk or cream that has been flavoured with a sweetener, either sugar or an alternative, and a spice, such as cocoa or vanilla, or with fruit, such as strawberries or peaches.',
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey,
              height: 1.16,
            ),
          ))
        ],
      );

  Widget buildTopDetails() => Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromRGBO(95, 163, 182, 1),
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CartScreen()));
                  },
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromRGBO(95, 163, 182, 1),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: Image.asset(
              'assets/${widget.coffeeCup.image}',
              fit: BoxFit.contain,
            ))
          ],
        ),
      );
}
