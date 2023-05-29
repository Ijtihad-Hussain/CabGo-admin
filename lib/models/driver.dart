
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Driver {
  final String name;
  final String phone;
  final String? imageUrl;

  Driver({required this.name, required this.phone, this.imageUrl});

  factory Driver.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Driver(
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      imageUrl: data['photoURL'],
    );
  }
}


// class Driver {
//   final String name;
//   final String? email;
//   final String phone;
//   final Image image;
//
//   Driver({required this.name, this.email, required this.image, required this.phone});
// }
//
//
// // create a list of doctors to display in the ListView
// final List<Driver> drivers = [
//   Driver(
//     name: 'Mr. John Doe',
//     image: Image.network('https://images.unsplash.com/photo-1449965408869-eaa3f722e40d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',height: 80, width: 50, fit: BoxFit.fill),
//     phone: '023920'
//   ),
//   Driver(
//     name: 'Mr. Jane Smith',
//     image: Image.network('https://images.unsplash.com/photo-1449965408869-eaa3f722e40d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80', height: 80, width: 50, fit: BoxFit.fill),
//     phone: '0923902',
//   ),
// ];