import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/driver.dart';

class Drivers extends StatefulWidget {
  static const String id = "webhomescreen";

  @override
  _DriversState createState() => _DriversState();
}

class _DriversState extends State<Drivers> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    // dispose the search text field controller
    _searchController.dispose();
    super.dispose();
  }

  // update the filtered list based on the current search query
  void _onSearchChanged() {
    setState(() {
      final query = _searchController.text.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search by name',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: drivers.length,
          //     itemBuilder: (context, index) {
          //       final driver = drivers[index];
          //       return Card(
          //         child: ListTile(
          //           leading: driver.image,
          //           title: Text(driver.name),
          //           subtitle: Text(driver.phone!),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('drivers').get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final drivers = snapshot.data!.docs.map((doc) => Driver.fromFirestore(doc)).toList();
                  return ListView.builder(
                    itemCount: drivers.length,
                    itemBuilder: (context, index) {
                      final driver = drivers[index];
                      String? image = driver.imageUrl;
                      return Card(
                        child: ListTile(
                          leading: Image.network(driver.imageUrl ?? 'https://images.unsplash.com/photo-1449965408869-eaa3f722e40d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
                          title: Text(driver.name),
                          subtitle: Text(driver.phone!),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: ElevatedButton(
          //     onPressed: () async {
          //       showDialog(
          //         context: context,
          //         builder: (BuildContext context) {
          //           String name = '';
          //           String phone = '';
          //           String image;
          //
          //           return AlertDialog(
          //             title: const Text('Add Driver'),
          //             content: SingleChildScrollView(
          //               child: Column(
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: [
          //                   TextField(
          //                     decoration: const InputDecoration(
          //                       labelText: 'Driver Name',
          //                     ),
          //                     onChanged: (value) {
          //                       name = value;
          //                     },
          //                   ),
          //                   TextField(
          //                     decoration: const InputDecoration(
          //                       labelText: 'Phone',
          //                     ),
          //                     onChanged: (value) {
          //                       phone = value;
          //                     },
          //                   ),
          //                   ElevatedButton(
          //                     onPressed: () async {
          //                       final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
          //                       if (pickedFile != null) {
          //                         final base64Data = base64.encode(await pickedFile.readAsBytes());
          //                         setState(() {
          //                           // image = Image.memory(base64.decode(base64Data), height: 80, width: 50, fit: BoxFit.fill);
          //                         });
          //                       }
          //                     },
          //                     child: const Text('Add Image'),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             actions: [
          //               TextButton(
          //                 child: const Text('Cancel'),
          //                 onPressed: () {
          //                   Navigator.of(context).pop();
          //                 },
          //               ),
          //               ElevatedButton(
          //                 child: const Text('Add'),
          //                 onPressed: () {
          //                   final newDriver = Driver(
          //                     name: name,
          //                     phone: phone,
          //                   );
          //                   setState(() {
          //                     drivers.add(newDriver);
          //                   });
          //                   Navigator.of(context).pop();
          //                 },
          //               ),
          //             ],
          //           );
          //         },
          //       );
          //     },
          //     child: const Text('Add Driver'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
