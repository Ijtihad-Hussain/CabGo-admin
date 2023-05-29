import 'package:cab_go_admin/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/requests.dart';

class RideRequests extends StatefulWidget {
  static const String id = "appointments";

  const RideRequests({Key? key}) : super(key: key);

  @override
  State<RideRequests> createState() => _WebAppointmentsState();
}

class _WebAppointmentsState extends State<RideRequests> {
//   final TextEditingController _searchController = TextEditingController();
//
//   List<Requests> _filteredAppointments = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _filteredAppointments = requests;
//     _searchController.addListener(_onSearchChanged);
//   }
//
//   @override
//   void dispose() {
//     _searchController.removeListener(_onSearchChanged);
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   void _onSearchChanged() {
//     setState(() {
//       String searchTerm = _searchController.text.toLowerCase();
//       _filteredAppointments = requests.where((request) {
//         return request.riderName.toLowerCase().contains(searchTerm) ||
//             request.driverName.toLowerCase().contains(searchTerm);
//       }).toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Appointments'),
//       // ),
//       body: Column(
//         children: <Widget>[
//           Container(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: const InputDecoration(
//                 hintText: 'Search by driver name, or rider name',
//                 suffixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _filteredAppointments.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   child: ListTile(
//                     title: GestureDetector(
//                         onTap: () {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) =>
//                                 _buildLogoutDialog(context),
//                           );
//                         },
//                         child: Text(_filteredAppointments[index].riderName)),
//                     subtitle: Text(_filteredAppointments[index].dateTime),
//                     trailing: Text(_filteredAppointments[index].driverName),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLogoutDialog(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Ride Details'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: const <Widget>[
//           Text("Rider Name: John Doe"),
//           Text("Driver Name: Mr. Smith"),
//           Text("Time: 2022-05-01 10:00"),
//         ],
//       ),
//       actions: <Widget>[
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: const Text('Edit'),
//         ),
//         TextButton(
//           onPressed: () {
//
//           },
//           child: const Text('Delete'),
//         ),
//       ],
//     );
//   }
// }

  late Stream<QuerySnapshot> _rideRequestsStream;

  @override
  void initState() {
    super.initState();
    _rideRequestsStream = FirebaseFirestore.instance
        .collection('rideRequests')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Ride Requests'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _rideRequestsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No ride requests found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final rideRequest = Appointment.fromFirestore(
                    snapshot.data!.docs[index]);
                return ListTile(
                  title: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildAppointmentDialog(context, rideRequest),
                      );
                    },
                    child: Text(rideRequest.riderName),
                  ),
                  subtitle: Text((rideRequest.dateTime).toDate().toString()),
                  trailing: Text(rideRequest.status),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildAppointmentDialog(BuildContext context, Appointment appointment) {
    return AlertDialog(
      title: Text('Ride Request Details'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Rider Name: ${appointment.riderName}'),
            Text('Pickup Location: ${appointment.pickupLocation}'),
            Text('Destination: ${appointment.destination}'),
            Text('Date and Time: ${appointment.dateTime}'),
            // Text('Driver Name: ${appointment.driverName}'),
            Text('Status: ${appointment.status}'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class Appointment {
  final String riderName;
  final String pickupLocation;
  final String destination;
  final Timestamp dateTime;
  // final String driverName;
  final String status;

  Appointment({
    required this.riderName,
    required this.pickupLocation,
    required this.destination,
    required this.dateTime,
    // required this.driverName,
    required this.status,
  });

  factory Appointment.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Appointment(
      riderName: data['name'],
      pickupLocation: data['pickupAddress'],
      destination: data['destinationAddress'],
      dateTime: data['createdAt'],
      // driverName: data['driverName'] ?? '',
      status: data['status'] ?? 'Pending',
    );
  }
}