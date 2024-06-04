import 'package:coffee_cup_ui/data/constants.dart';
import 'package:coffee_cup_ui/screens/cart_screen.dart';
import 'package:coffee_cup_ui/screens/coffee_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 249, 250, 1),
      body: Stack(
        children: [
          ClipPath(
            clipper: BackgroundClipper(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromRGBO(141, 193, 208, 1),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: buildHeader()),
              Expanded(flex: 4, child: buildBestCoffee()),
              Expanded(flex: 3, child: buildPopularCoffee()),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPopularCoffee() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              'Most Popular',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(58, 72, 89, 1)),
            ),
          ),
          Expanded(child: buildPopularCoffeeItems())
        ],
      );

  Widget buildPopularCoffeeItems() => ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 20, right: 10),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final coffee = coffeeCups[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CoffeeDetailsScreen(
                      coffeeCup: coffee,
                    )));
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.22,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(95, 163, 182, 1),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              coffee.rating.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              coffee.name,
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
                              '\$${coffee.price}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    right: 0,
                    top: 0,
                    child: Image.asset(
                      'assets/${coffee.image}',
                      height: MediaQuery.of(context).size.height * 0.18,
                    ))
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
            width: 10,
          ),
      itemCount: coffeeCups.length);

  Widget buildBestCoffee() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              'Best Coffee in Town',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
              child: TabBar(
            controller: controller,
            isScrollable: true,
            indicatorColor: Colors.transparent,
            tabs: coffeeCategories.map((e) {
              return Text(
                e,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList(),
          )),
          Expanded(
              flex: 5,
              child: TabBarView(controller: controller, children: [
                buildBestCoffeeItems(),
                const Center(
                  child: Text(
                    'Tea',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'Drink',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ]))
        ],
      );

  Widget buildBestCoffeeItems() => ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 20, right: 10),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final coffee = coffeeCups[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CoffeeDetailsScreen(
                      coffeeCup: coffee,
                    )));
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.29,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(95, 163, 182, 1),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              coffee.rating.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              coffee.name,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${coffee.price}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    coffee.favorite
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    right: 0,
                    top: 0,
                    child: Image.asset(
                      'assets/${coffee.image}',
                      height: MediaQuery.of(context).size.height * 0.25,
                    ))
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
            width: 10,
          ),
      itemCount: coffeeCups.length);

  Widget buildHeader() => SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            Row(
              children: [
                const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 15,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CartScreen()));
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ))
              ],
            )
          ],
        ),
      ));
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double h = size.height;
    double w = size.width;
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, h * 0.6)
      ..quadraticBezierTo(w * 0.5, h, w, h * 0.6)
      ..lineTo(w, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
