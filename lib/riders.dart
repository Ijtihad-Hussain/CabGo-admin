import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/riders.dart';

class RidersPage extends StatefulWidget {
  static const String id = "webpatients";

  const RidersPage({Key? key}) : super(key: key);

  @override
  State<RidersPage> createState() => _RidersPageState();
}

class _RidersPageState extends State<RidersPage> {
//   late List<Riders> _filteredRiders;
//
//   final _searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _filteredRiders = riders;
//   }
//
//   void _filterRiders(String query) {
//     setState(() {
//       _filteredRiders = riders.where((rider) {
//         final nameLower = rider.name.toLowerCase();
//         final emailLower = rider.email.toLowerCase();
//         final phoneNumber = rider.phoneNumber;
//         final queryLower = query.toLowerCase();
//
//         return nameLower.contains(queryLower) ||
//             emailLower.contains(queryLower) ||
//             phoneNumber.contains(queryLower);
//       }).toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: const InputDecoration(
//                 hintText: 'Search rider',
//                 suffixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: (value) {
//                 _filterRiders(value);
//               },
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _filteredRiders.length,
//               itemBuilder: (context, index) {
//                 final rider = _filteredRiders[index];
//                 return Card(
//                   child: ListTile(
//                     title: Text(rider.name),
//                     subtitle: Text(rider.email),
//                     trailing: Text(rider.phoneNumber),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
  late Stream<QuerySnapshot> _ridersStream;

  @override
  void initState() {
    super.initState();
    _ridersStream = FirebaseFirestore.instance.collection('users').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Riders'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ridersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final riders = snapshot.data!.docs.map((doc) => Rider.fromFirestore(doc)).toList();

          return ListView.builder(
            itemCount: riders.length,
            itemBuilder: (context, index) {
              final rider = riders[index];

              return Card(
                child: ListTile(
                  leading: rider.image != null ? Image.network(rider.image!) : Icon(Icons.person),
                  title: Text(rider.name!),
                  subtitle: Text(rider.email!),
                  onTap: () {
                    // Handle rider details onTap
                    print('Selected rider: ${rider.name}');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Rider {
  final String? name;
  final String? email;
  final String? image;
  final String? phone;

  Rider({
    required this.name,
    required this.email,
    this.image,
    this.phone,
  });

  factory Rider.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Rider(
      name: data['name'],
      email: data['email'],
      image: data['image'],
      phone: data['phone'],
    );
  }
}
