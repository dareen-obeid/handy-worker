import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<DocumentSnapshot> _allResults = [];
  List<DocumentSnapshot> _resultsList = [];
  bool _showFilterScreen = false;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getWorkersStream();
  }

  Future<void> getWorkersStream() async {
    var data = await FirebaseFirestore.instance
        .collection('workers')
        .orderBy('service')
        .get();
    setState(() {
      _allResults = data.docs;
    });
  }

  void _filterResults(String searchQuery) {
    List<DocumentSnapshot> searchResults = _allResults.where((snapshot) {
      var service = snapshot['service'].toString().toLowerCase();
      return service.contains(searchQuery.toLowerCase());
    }).toList();

    setState(() {
      _resultsList = searchResults;
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _resultsList = [];
    });
  }

  void _toggleFilterScreen() {
    setState(() {
      _showFilterScreen = !_showFilterScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search for Services',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      prefixIconConstraints:
                          BoxConstraints(minWidth: 40, maxHeight: 40),
                    ),
                    onChanged: (searchQuery) {
                      _filterResults(searchQuery);
                    },
                  ),
                ),
                IconButton(
                  onPressed: _toggleFilterScreen,
                  icon: Icon(Icons.filter_list, color: Colors.grey),
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: _clearSearch,
                  icon: Icon(Icons.clear, color: Colors.grey),
                ),
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
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  Expanded(
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
          Expanded(
            child: ListView.builder(
              itemCount: _resultsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_resultsList[index]['service']),
                  subtitle: Text(_resultsList[index]['firstName']),
                  trailing: Text(_resultsList[index]['email']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
/**** */