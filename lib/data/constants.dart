import 'package:coffee_cup_ui/model/coffee_cup.dart';
import 'package:coffee_cup_ui/model/coffee_extra.dart';

List<String> coffeeCategories = ['Coffee', 'Tea', 'Drink'];
List<CoffeeCup> coffeeCups = [
  CoffeeCup(
      image: 'coffeeCup1.png',
      name: 'Coffee Americano',
      price: 25,
      rating: 4.4,
      favorite: true),
  CoffeeCup(
      image: 'coffeeCup2.png',
      name: 'Irish Coffee',
      price: 23,
      rating: 4.0,
      favorite: false),
  CoffeeCup(
      image: 'coffeeCup3.png',
      name: 'Cold Coffee',
      price: 20,
      rating: 4.2,
      favorite: true),
  CoffeeCup(
      image: 'coffeeCup4.png',
      name: 'Latte Coffee',
      price: 22,
      rating: 4.1,
      favorite: false),
];

List<Extra> extras = [
  Extra(image: 'chocolate.png', name: 'Chocolate', price: 18),
  Extra(image: 'iceCream.png', name: 'Ice Cream', price: 15),
  Extra(image: 'shake.png', name: 'Milk Shake', price: 20),
];
