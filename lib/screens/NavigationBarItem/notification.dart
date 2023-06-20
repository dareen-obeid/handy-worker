import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<String> services = [
    "All",
    "Electrical work",
    "Plumbing",
    "Painting",
    "Blacksmithing",
    "Welding",
    "Glasswork",
    "Appliance repair",
    "Tiling",
    "Carpentry",
    "HVAC",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
                  const SizedBox(height: 20),

        Text("Notification")
        // Container(
        //   height: 40,
        //   child: ListView.builder(
        //     scrollDirection: Axis.horizontal,
        //     itemCount: services.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       bool isSelected = (index == 0); // Select the "All" option by default

        //       return Container(
        //         width: 106,
        //         margin: const EdgeInsets.only(left: 4, right: 4),
        //         decoration: BoxDecoration(
        //           color: isSelected ? const Color(0xFF00ABB3) : Colors.white,
        //           borderRadius: BorderRadius.circular(20),
        //           border: Border.all(
        //             color: const Color(0xFF00ABB3),
        //             width: 2,
        //           ),
        //         ),
        //         child: Center(
        //           child: Text(
        //             services[index],
        //             style: TextStyle(
        //               fontSize: 12,
        //               color: isSelected ? Colors.white : const Color(0xFF00ABB3),
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        // ),
        // // const SizedBox(height: 8),
        // const Text(
        //   "Top Ten",
        //   style: TextStyle(
        //     fontSize: 16,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
      ],
    );
  }
}
