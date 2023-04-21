import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../models/worker.dart';

class WorkerFromUser extends StatefulWidget {
  final Worker worker;

  const WorkerFromUser({ Key? key, required this.worker }) : super(key: key);

  @override
  _WorkerFromUserState createState() => _WorkerFromUserState();
}


class _WorkerFromUserState extends State<WorkerFromUser> {

  late String? email;
  late String photo = "";

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    email = user?.email ?? ' ';
    photo =user?.photoURL ?? ' ';
 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00ABB3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Worker Details",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.worker.firstName} ${widget.worker.lastName}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Service: ${widget.worker.service}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              "City: ${widget.worker.city}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              "Bio: ${widget.worker.description}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            // Text(
            //   "Experience: ${widget.worker.experience} years",
            //   style: TextStyle(fontSize: 18),
            // ),
          ],
        ),
      ),
    );
  }
}


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../../../models/worker.dart';

// class WorkerFromUser extends StatefulWidget {
//   final Worker worker;

//   const WorkerFromUser({ Key? key, required this.worker }) : super(key: key);

//   @override
//   _WorkerFromUserState createState() => _WorkerFromUserState();
// }


// class _WorkerFromUserState extends State<WorkerFromUser> {

//   late String? email;
//   late String photo = "";

//   @override
//   void initState() {
//     super.initState();
//     final user = FirebaseAuth.instance.currentUser;
//     email = user?.email ?? ' ';
//     photo =user?.photoURL ?? ' ';
 
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF00ABB3),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           color: Colors.white,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text(
//           "Worker Details",
//           style: TextStyle(
//               color: Color.fromARGB(255, 255, 255, 255),
//               fontSize: 24,
//               fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Card(
//           elevation: 4.0,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 width: 120.0,
//                 height: 120.0,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(8.0),
//                   child: Image.network(
//                     photo,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               SizedBox(width: 16.0),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 16.0),
//                   Text(
//                     "${widget.worker.firstName} ${widget.worker.lastName}",
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8.0),
//                   Text(
//                     "${widget.worker.city}",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
