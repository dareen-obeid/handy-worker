import 'package:flutter/material.dart';

import '../../reusable_widgets/reusable_widget.dart';
import '../../reusable_widgets/utils/color_utils.dart';
import 'first_screen.dart';


class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("FFFFFF"),
            hexStringToColor("FFFFFF")
          ])),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  0, MediaQuery.of(context).size.height * 0.05, 0, 0),
              child: Column(children: <Widget>[
                Image.asset(
                  "images/page2.png",
                  height: 500,
                  width: double.infinity,
                ),

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF00ABB3).withOpacity(0.2),
                        ),
                      ),
                      const SizedBox(width: 10), // add some space between the circles
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF00ABB3),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                    "We provide professional service at a friendly price",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                getstart(context, "Get Start", () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const FirstScreen()));
                }),
                
              ]
              ),
            ),
          )
        ),
    );
  }
}
