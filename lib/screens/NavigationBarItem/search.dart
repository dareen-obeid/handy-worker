import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _showFilterScreen = false;

  void _toggleFilterScreen() {
    setState(() {
      _showFilterScreen = !_showFilterScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search for Services',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    prefixIconConstraints: BoxConstraints(minWidth: 40, maxHeight: 40),
                  ),
                ),
              ),
              IconButton(
                onPressed: _toggleFilterScreen,
                icon: const Icon(Icons.filter_list, color: Colors.grey),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        if (_showFilterScreen)
          Container(
            color: Colors.white.withOpacity(0.9),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: _toggleFilterScreen,
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Filter Screen',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
