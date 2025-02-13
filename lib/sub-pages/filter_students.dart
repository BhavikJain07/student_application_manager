import 'package:flutter/material.dart';
import 'package:student_application_manager_new/utils/supabase_utils.dart';

class FilterStudents extends StatefulWidget {
  const FilterStudents({super.key});

  @override
  State<FilterStudents> createState() => _FilterStudentsState();
}

class _FilterStudentsState extends State<FilterStudents> {
  List<Map<dynamic, dynamic>> _filteredStudents = <Map<dynamic, dynamic>>[];
  bool rankFilter = false;

  void _fetchStudents() async {
    final List<Map<dynamic, dynamic>> data =
        await fetchFilteredStudents("bcom", rankFilter);
    setState(() {
      _filteredStudents = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  label: Text("Search"),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            OutlinedButton.icon(
              onPressed: _fetchStudents,
              label: Text("Filter"),
              icon: Icon(Icons.filter_alt),
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              children: [
                Switch(
                  value: rankFilter,
                  onChanged: (value) {
                    setState(() {
                      rankFilter = value;
                    });
                  },
                ),
                Text("Rank Filter"),
              ],
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredStudents.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(_filteredStudents[index]["firstName"]),
                subtitle: Text(
                    "XII: ${_filteredStudents[index]["xiiPercentage"]} | X: ${_filteredStudents[index]["xPercentage"]}"),
              );
            },
          ),
        ),
      ],
    );
  }
}
