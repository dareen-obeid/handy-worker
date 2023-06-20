import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  final List<DocumentSnapshot> resultsList;
  final List<DocumentSnapshot> allResults;

  const FilterPage({
    Key? key,
    required this.resultsList,
    required this.allResults,
  }) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<DocumentSnapshot> _filteredResults = [];
  final List<String> _cities = [
    "Jerusalem",
    "Ramallah",
    "Bethlehem",
    "Nablus",
    "Hebron",
    "Jericho",
    "Jenin",
    "Tulkarm",
  ];
  double _minRating = 0;
  double _maxRating = 5;
  String? _selectedCity;
  String _nameFilter = '';
  String? _selectedDay;
  int? _selectedStartHour;
  int? _selectedEndHour;
  Map<String, String> _selectedAvailability = {};

  @override
  void initState() {
    super.initState();
    if (widget.resultsList.isNotEmpty) {
      _filteredResults = widget.resultsList;
    } else {
      _filteredResults = widget.allResults;
    }
  }

  void _applyFilters() {
    List<DocumentSnapshot> filteredList;

    if (widget.resultsList.isNotEmpty) {
      filteredList = widget.resultsList;
    } else {
      filteredList = widget.allResults;
    }

    // Filter by city
    if (_selectedCity != null) {
      filteredList = filteredList.where((snapshot) {
        var city = snapshot['city'].toString().toLowerCase();
        return city == _selectedCity!.toLowerCase();
      }).toList();
    }

    // Filter by rating
    filteredList = filteredList.where((snapshot) {
      var rating = snapshot['rating'] ?? 0;
      return rating >= _minRating && rating <= _maxRating;
    }).toList();

    // Filter by name
    filteredList = filteredList.where((snapshot) {
      var firstName = snapshot['firstName'].toString().toLowerCase();
      var lastName = snapshot['lastName'].toString().toLowerCase();
      var fullName = firstName + ' ' + lastName;
      return fullName.contains(_nameFilter.toLowerCase());
    }).toList();

    // Filter by availability
    if (_selectedAvailability.isNotEmpty) {
      filteredList = filteredList.where((snapshot) {
        var availability = snapshot['availability'];
        if (availability is Map<String, dynamic>) {
          return _selectedAvailability.entries.every((entry) {
            var selectedDay = entry.key;
            var selectedAvailability = entry.value;
            var workerAvailability = availability[selectedDay];

            if (workerAvailability != null && workerAvailability is String) {
              var startHour = int.parse(workerAvailability.split('-')[0]);
              var endHour = int.parse(workerAvailability.split('-')[1]);

              var selectedStartHour =
                  int.parse(selectedAvailability.split('-')[0]);
              var selectedEndHour =
                  int.parse(selectedAvailability.split('-')[1]);

              return (startHour >= selectedStartHour &&
                  endHour <= selectedEndHour);
            }

            return false;
          });
        }

        return false;
      }).toList();
    }

    // Pass the filtered results back to the SearchPage
    Navigator.pop(context, {'filteredResults': filteredList});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00ABB3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Favorite Workers',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _applyFilters,
            icon: const Icon(Icons.check),
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _nameFilter = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Enter name',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'City',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButtonFormField<String>(
              value: _selectedCity,
              items: _cities
                  .map((city) => DropdownMenuItem(
                        value: city,
                        child: Text(city),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCity = value;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Availability',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<String>(
                    value: _selectedDay,
                    items: [
                      'Monday',
                      'Tuesday',
                      'Wednesday',
                      'Thursday',
                      'Friday',
                      'Saturday',
                      'Sunday',
                    ]
                        .map((day) => DropdownMenuItem(
                              value: day,
                              child: Text(day),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDay = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: _selectedStartHour,
                          items: List.generate(
                            24,
                            (index) => DropdownMenuItem(
                              value: index,
                              child: Text(index.toString()),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _selectedStartHour = value;
                            });
                          },
                        ),
                      ),
                      const Text('to'),
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: _selectedEndHour,
                          items: List.generate(
                            24,
                            (index) => DropdownMenuItem(
                              value: index,
                              child: Text(index.toString()),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _selectedEndHour = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_selectedDay != null &&
                        _selectedStartHour != null &&
                        _selectedEndHour != null) {
                      final availability =
                          '$_selectedStartHour-${_selectedEndHour.toString()}';
                      setState(() {
                        _selectedAvailability[_selectedDay!] = availability;
                        _selectedDay = null;
                        _selectedStartHour = null;
                        _selectedEndHour = null;
                      });
                    }
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_selectedAvailability.isNotEmpty) const SizedBox(height: 16),
            const Text(
              'Selected Availability',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _selectedAvailability.entries
                  .map(
                    (entry) => ListTile(
                      title: Text(entry.key),
                      subtitle: Text(entry.value),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            _selectedAvailability.remove(entry.key);
                          });
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 30),
            const Text(
              'Rating',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _minRating,
                    min: 0,
                    max: 5,
                    divisions: 10,
                    onChanged: (value) {
                      setState(() {
                        _minRating = value;
                      });
                    },
                    activeColor: const Color(0xFF00ABB3),
                  ),
                ),
                Text(
                  _minRating.toStringAsFixed(1),
                  style: const TextStyle(color: Color(0xFF00ABB3)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
