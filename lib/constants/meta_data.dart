import 'package:products_management/data/models/models.dart';

const List<String> productImages = [
  'https://images.unsplash.com/photo-1562183241-b937e95585b6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=465&q=80',
  'https://images.unsplash.com/photo-1585386959984-a4155224a1ad?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTN8fHByb2R1Y3RzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
  'https://images.unsplash.com/photo-1558108545-a0f86eda7d55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  'https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  'https://images.unsplash.com/photo-1560769629-975ec94e6a86?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
  'https://images.unsplash.com/photo-1620799139507-2a76f79a2f4d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=772&q=80',
];

const List<double> productPrices = [
  58.50,
  120.0,
  79.40,
  99.80,
  30.40,
  65.30,
];

const List<String> productCategoriesList = [
  'Computers & tablets',
  'Cell phones & accessories',
  'TV, audio & surveillance',
  'Fashion',
  'Home & garden',
  'Sporting goods',
  'Foods',
  'Toys & hobbies',
  'Other'
];

List<Category> categories = [
  Category(id: 1, name: 'Fashion'),
  Category(id: 2, name: 'Home & Decore'),
  Category(id: 3, name: 'Electronics'),
  Category(id: 4, name: 'Food'),
];

List<User> users = [
  User(id: 1, name: 'Alaa Zamel', email: 'alaa.zamel80@gmail.com'),
  User(id: 2, name: 'Fares Dabbas', email: 'fares.dabbas@gmail.com'),
  User(id: 3, name: 'Sham Tuameh', email: 'sham.tuameh@gmail.com'),
  User(id: 4, name: 'Hadi Barakat', email: 'hadi.barakat@gmail.com'),
  User(id: 5, name: 'Touka Ramadan', email: 'touka.ramadan@gmail.com'),
];

List<Product> productsList = [
  Product(
    id: 1,
    name: 'iPhone 13 pro',
    price: 1240.0,
    imageUrl:
        'https://fdn2.gsmarena.com/vv/pics/apple/apple-iphone-13-pro-max-4.jpg',
    expiryDate: '2024-10-05T07:48:00.000Z',
    category: categories[2],
    phoneNumber: '+963991146587',
    quantity: 15,
    owner: users[1],
  ),
  Product(
    id: 2,
    name: 'Samsung S21 Ultra',
    price: 200.0,
    imageUrl:
        'https://fdn2.gsmarena.com/vv/pics/samsung/samsung-galaxy-s21-ultra-5g-4.jpg',
    expiryDate: '2024-10-05T07:48:00.000Z',
    category: categories[2],
    phoneNumber: '+963948821379',
    quantity: 8,
    owner: users[3],
  ),
  Product(
    id: 3,
    name: 'Addidas Shoes',
    price: 840.0,
    imageUrl:
        'https://images.unsplash.com/photo-1562183241-b937e95585b6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=465&q=80',
    expiryDate: '2025-10-05T07:48:00.000Z',
    category: categories[1],
    phoneNumber: '+963948821379',
    quantity: 7,
    owner: users[4],
  ),
  Product(
    id: 4,
    name: 'Sony Xperia Pro I',
    price: 999.0,
    imageUrl:
        'https://fdn.gsmarena.com/imgroot/reviews/21/sony-xperia-pro-i/preview/lifestyle/-1024w2/gsmarena_006.jpg',
    expiryDate: '2023-02-13T07:48:00.000Z',
    category: categories[2],
    phoneNumber: '+963947804651',
    quantity: 23,
    owner: users[2],
  ),
  Product(
    id: 5,
    name: 'iPhone 12 Pro',
    price: 1099.0,
    imageUrl: 'https://fdn2.gsmarena.com/vv/pics/apple/apple-iphone-12-4.jpg',
    expiryDate: '2024-10-05T07:48:00.000Z',
    category: categories[2],
    phoneNumber: '+963948821379',
    quantity: 37,
    owner: users[1],
  ),
];
