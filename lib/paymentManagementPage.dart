import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class PaymentManagementPage extends StatefulWidget {
  static const String id = "PaymentDetailPage";
  @override
  _PaymentManagementPageState createState() => _PaymentManagementPageState();
}

class _PaymentManagementPageState extends State<PaymentManagementPage> {
  late Stream<QuerySnapshot> _paymentsStream;

  @override
  void initState() {
    super.initState();
    _paymentsStream =
        FirebaseFirestore.instance.collection('completedTrips').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Payments'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _paymentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final payments = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Payment(
              amount: data['fare'] ?? 0.0,
              driverName: data['driverName'] ?? '',
              driverPhone: data['driverPhone'] ?? '',
            );
          }).toList();

          return ListView.builder(
            itemCount: payments.length,
            itemBuilder: (BuildContext context, int index) {
              final payment = payments[index];
              return ListTile(
                title: Text('Amount: \$${payment.amount}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Driver Name: ${payment.driverName}'),
                    Text('Driver Phone: ${payment.driverPhone}'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Payment {
  final double amount;
  final String driverName;
  final String driverPhone;

  Payment({
    required this.amount,
    required this.driverName,
    required this.driverPhone,
  });
}