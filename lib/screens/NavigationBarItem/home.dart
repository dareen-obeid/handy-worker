import 'package:flutter/material.dart';
import 'package:handyworker/screens/NavigationBarItem/WorkerListPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _buildCategoriesRow([
            {
              'color': const Color.fromARGB(255, 101, 205, 250),
              'icon': Icons.electrical_services,
              'label': 'Electrician'
            },
            {
              'color': const Color.fromARGB(255, 250, 107, 107),
              'icon': Icons.plumbing,
              'label': 'Plumbing'
            },
            {
              'color': const Color.fromARGB(255, 143, 241, 187),
              'icon': Icons.construction,
              'label': 'Construction'
            },
            {
              'color': const Color.fromARGB(255, 178, 221, 125),
              'icon': Icons.format_paint,
              'label': 'Painting'
            },
            {
              'color': const Color.fromARGB(255, 253, 149, 93),
              'icon': Icons.ac_unit,
              'label': 'House Cleaning'
            },
          ]),
          // Add other content here
        ],
      ),
    );
  }

  Widget _buildCategoriesRow(List<Map<String, dynamic>> categories) {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 4,vertical: 20),
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return _buildCategoryItem(
            categories[index]['color'],
            categories[index]['icon'],
            categories[index]['label'],
          );
        },
      ),
    );
  }
Widget _buildCategoryItem(Color color, IconData icon, String label) {
  return SizedBox(
    width: 95,
    child: Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WorkerListPage(service: label),
              ),
            );
          },
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

}
