import 'package:cab_go_admin/paymentManagementPage.dart';
import 'package:cab_go_admin/utils/constants.dart';
import 'package:cab_go_admin/rideRequests.dart';
import 'package:cab_go_admin/dashboard.dart';
import 'package:cab_go_admin/drivers.dart';
import 'package:cab_go_admin/riders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class WebHomeScreen extends StatefulWidget {
  static const String id = "webdoctors";

  const WebHomeScreen({Key? key}) : super(key: key);

  @override
  State<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen> {
  Widget selectedSCreen = WebDashBoard();
  chooseScreens(item) {
    switch (item.route) {
      case WebDashBoard.id:
        setState(() {
          selectedSCreen = WebDashBoard();
        });
        break;
      case Drivers.id:
        setState(() {
          selectedSCreen = Drivers();
        });
        break;
      case RideRequests.id:
        setState(() {
          selectedSCreen = RideRequests();
        });
        break;
      case RidersPage.id:
        setState(() {
          selectedSCreen = RidersPage();
        });
        break;
      case PaymentManagementPage.id:
        setState(() {
          selectedSCreen = PaymentManagementPage();
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: kLBlack,
          title: const Center(child: Text('Dashboard')),
          actions: <Widget>[
            // IconButton(
            //   icon: const Icon(Icons.notifications_sharp),
            //   tooltip: 'Notification Icon',
            //   onPressed: () {
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(builder: (context) => SplashScreen()),
            //     // );
            //   },
            // ), //IconButton
            // const Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: CircleAvatar(
            //     backgroundImage: AssetImage('assets/images/IJH.jpg'),
            //     radius: 22,
            //   ),
            // ), //IconButton
          ],
        ),
        sideBar: SideBar(
            onSelected: (item) {
              chooseScreens(item);
            },
            items: const [
              AdminMenuItem(
                title: 'Dashboard',
                route: WebDashBoard.id,
                // icon: Icons.dashboard,
              ),
              AdminMenuItem(
                title: 'Ride Requests',
                route: RideRequests.id,
                // icon: Icons.dashboard,
              ),
              AdminMenuItem(
                title: 'Drivers',
                route: Drivers.id,
              ),
              AdminMenuItem(
                title: 'Riders',
                route: RidersPage.id,
              ),
              AdminMenuItem(
                title: 'Payments',
                route: PaymentManagementPage.id,
              ),
            ],
            selectedRoute: WebHomeScreen.id),
        body: selectedSCreen);
  }
}
