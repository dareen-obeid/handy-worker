import 'package:flutter/material.dart';

import '../../reusable_widgets/utils/color_utils.dart';

class AccountWorker extends StatefulWidget {
  const AccountWorker({ Key? key }) : super(key: key);

  @override
  _AccountWorkerState createState() => _AccountWorkerState();
}

class _AccountWorkerState extends State<AccountWorker> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: const Color(0xFF626262),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "Account",
            style: TextStyle(
                color: Color(0xFF626262),
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("FFFFFF"),
            hexStringToColor("FFFFFF")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),

        ));
  }
}