import 'package:flutter/material.dart';
class NotificationPage extends StatefulWidget {
  const NotificationPage({ Key? key }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text("noti"),
      ),
      
    );
  }
}