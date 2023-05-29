import 'package:cab_go_admin/utils/adminBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WebDashBoard extends StatefulWidget {
  static const String id = "webdashboard";

  const WebDashBoard({Key? key}) : super(key: key);

  @override
  State<WebDashBoard> createState() => _WebDashBoardState();
}

class _WebDashBoardState extends State<WebDashBoard> {
  QuerySnapshot<Map<String, dynamic>>? completedRides;

  Future<void> getCompletedRides() async {
    completedRides = await FirebaseFirestore.instance
        .collection('rideRequests')
        .where('status', isEqualTo: 'completed')
        .get();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCompletedRides();
  }

  @override
  Widget build(BuildContext context) {
    final rideRequestsCollection = FirebaseFirestore.instance.collection('rideRequests');
    final ridesCollection = FirebaseFirestore.instance.collection('completedTrips');
    final driversCollection = FirebaseFirestore.instance.collection('drivers');
    final ridersCollection = FirebaseFirestore.instance.collection('users');
    return SingleChildScrollView(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => WebAppointments()));
                    },
                    child: StreamBuilder<QuerySnapshot>(
                      stream: rideRequestsCollection.snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return AdminBox(title: 'Ride Requests', number: 0);
                        } else {
                          return AdminBox(
                              title: 'Ride Requests',
                              number: snapshot.data!.size.toDouble());
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: driversCollection.snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const AdminBox(
                          title: 'Drivers',
                          number: 0,
                          color: Colors.redAccent,
                        );
                      } else {
                        return AdminBox(
                          title: 'Drivers',
                          number: snapshot.data!.size.toDouble(),
                          color: Colors.redAccent,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: ridersCollection.snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return AdminBox(
                          title: 'Riders',
                          number: 0,
                          color: Colors.lightGreenAccent,
                        );
                      } else {
                        return AdminBox(
                          title: 'Riders',
                          number: snapshot.data!.size.toDouble(),
                          color: Colors.lightGreenAccent,
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: ridesCollection.snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return AdminBox(
                          title: 'Completed Rides',
                          number: 0,
                          color: Colors.lightBlueAccent,
                        );
                      } else {
                        return AdminBox(
                          title: 'Completed Rides',
                          number: snapshot.data!.size.toDouble(),
                          color: Colors.lightGreenAccent,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
