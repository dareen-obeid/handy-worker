
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handyworker/screens/login-signup/signin_screen.dart';

class Homesreen extends StatefulWidget {
  const Homesreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomesreenState createState() => _HomesreenState();
}

class _HomesreenState extends State<Homesreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset(
                  'images/worker-icon.png',
                  width: 24.09,
                  height: 24.09,
                ),
                const SizedBox(width: 8),
                const Text(
                  "Handy Worker",
                  style: TextStyle(color: Color(0xff00abb3)),
                ),
              ],
            ),
            IconButton(
              icon: const SizedBox(
                width: 32,
                height: 32,
                child: Icon(Icons.favorite_border, color: Colors.black),
              ),
              onPressed: () {
                // add favorite functionality here
              },
            ),
          ],
        ),
      ),
      body: // add your page content here
          Container(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor:  const Color(0xff00abb3),

        iconSize: 25,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,),
            
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications,),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

//NavigationBar
        // bottomNavigationBar: const GNav(
        //   gap: 8,
        //   tabs: [
        //     GButton(
        //       icon: Icons.home,
        //       text: 'Home',
        //       ),
        //     GButton(
        //       icon: Icons.search,
        //       text: 'Search',

        //       ),
        //     GButton(
        //       icon: Icons.favorite_border,
        //       text: 'Home',
        //       ),
        //     GButton(
        //       icon: Icons.person,
        //       text: 'Person',
        //       ),

        //   ]
        // )

// title: Row(  appbar
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       Row(
//         children: <Widget>[
//           Icon(Icons.work),
//           SizedBox(width: 8),
//           Text("Handy Worker"),
//         ],
//       ),
//       IconButton(
//         icon: Icon(Icons.favorite),
//         onPressed: () {
//           // add favorite functionality here
//         },
//       ),
//     ],
//   ),
// class _HomesreenState extends State<Homesreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: ElevatedButton(
//         child: const Text("Logout"),
//         onPressed: () {
//           FirebaseAuth.instance.signOut().then((value) {
//             print("Sign out");
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => const SignInScreen()));
//           });
//         },
//       )),
//     );
//   }
// }

// Container(
//   // frame48095556fzQ (52:1722)
//   margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 165*fem, 0*fem),
//   height: double.infinity,
//   child: Row(
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Container(
//         // frame34553oqi (52:1723)
//         margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 14*fem, 0*fem),
//         width: 24.09*fem,
//         height: 24.09*fem,
//         child: Image.asset(
//           'assets/page-1/images/frame-34553.png',
//           width: 24.09*fem,
//           height: 24.09*fem,
//         ),
//       ),
//       Center(
//         // handyworkervQY (48:201)
//         child: Text(
//           'HANDY WORKER',
//           textAlign: TextAlign.center,
//           style: SafeGoogleFont (
//             'OdorMeanChey',
//             fontSize: 14*ffem,
//             fontWeight: FontWeight.w400,
//             height: 3*ffem/fem,
//             color: Color(0xff00abb3),
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
