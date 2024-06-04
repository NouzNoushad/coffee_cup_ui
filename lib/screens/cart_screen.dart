import 'dart:convert';

import 'package:coffee_cup_ui/data/database.dart';
import 'package:coffee_cup_ui/screens/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  MyDb myDb = MyDb();
  List<Map> cartItems = [];

  @override
  void initState() {
    myDb.open();
    getCartItems();
    super.initState();
  }

  getCartItems() {
    Future.delayed(const Duration(seconds: 1), () async {
      cartItems = await myDb.db!.rawQuery('SELECT * FROM coffeeCarts');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 249, 250, 1),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(child: buildCartHeader()),
          Expanded(flex: 6, child: buildCartItems()),
          Expanded(child: buildCartButton()),
        ],
      )),
    );
  }

  Widget buildCartButton() {
    num total = cartItems.fold(0, (prev, element) => prev + element['price']);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(58, 72, 89, 1),
                ),
              ),
              Text(
                '\$${total.toString()}.00',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(58, 72, 89, 1),
                ),
              ),
            ],
          )),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              flex: 2,
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(95, 163, 182, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Buy Now',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget buildCartItems() => ListView.separated(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final cart = cartItems[index];
        List<dynamic> extras = jsonDecode(cart['extras']);
        return Slidable(
          endActionPane: ActionPane(
              extentRatio: 0.2,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (ct) async {
                    await myDb.db!.rawDelete(
                        'DELETE FROM coffeeCarts WHERE id = ?',
                        [cart['id']]).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.white,
                          content: Text(
                            'Product Removed from the Cart',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          )));
                    });

                    getCartItems();
                  },
                  backgroundColor: const Color.fromRGBO(141, 193, 208, 1),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  borderRadius: BorderRadius.circular(10),
                )
              ]),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.22,
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.17,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(95, 163, 182, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            color: Colors.transparent,
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  cart['title'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  '\$${cart['price']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 10,
                                      backgroundColor:
                                          Color.fromRGBO(141, 193, 208, 1),
                                      child: Icon(
                                        Icons.remove,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '1',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    CircleAvatar(
                                      radius: 10,
                                      backgroundColor:
                                          Color.fromRGBO(141, 193, 208, 1),
                                      child: Icon(
                                        Icons.add,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                Transform(
                  transform: Matrix4.translationValues(10, 0, 0),
                  child: Image.asset('assets/${cart['image']}'),
                ),
                Positioned(
                    bottom: 20,
                    left: 100,
                    child: Stack(
                      children: [
                        ...List.generate(
                            extras.length,
                            (index) => Transform(
                                  transform: Matrix4.translationValues(
                                      index * 20, 0, 0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 15,
                                    child: Image.asset(
                                      'assets/${extras[index]}',
                                    ),
                                  ),
                                ))
                      ],
                    )),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
      itemCount: cartItems.length);

  Widget buildCartHeader() => Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const BottomNavigationScreen()),
              ),
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromRGBO(95, 163, 182, 1),
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            const Text(
              'Cart List',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(58, 72, 89, 1),
              ),
            ),
            const SizedBox(
              width: 35,
            ),
          ],
        ),
      );
}
