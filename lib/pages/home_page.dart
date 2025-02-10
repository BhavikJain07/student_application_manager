import 'package:flutter/material.dart';
import 'package:student_application_manager_new/sub-pages/all_students.dart';
import 'package:student_application_manager_new/sub-pages/new_student.dart';
import 'package:student_application_manager_new/sub-pages/filter_students.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final List<NavigationRailDestination> destinations =
      <NavigationRailDestination>[
    NavigationRailDestination(
      icon: Icon(Icons.create),
      label: Text("New Student"),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.data_thresholding),
      label: Text("All Students"),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.filter_alt),
      label: Text("Filter Students"),
    ),
  ];

  final List<Widget> _destionations = <Widget>[
    NewStudent(),
    AllStudents(),
    FilterStudents(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Students Application Manager"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 1,
        ),
        body: Row(
          children: <Widget>[
            NavigationRail(
              elevation: 1,
              extended: true,
              destinations: destinations,
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Center(
                  child: _destionations[selectedIndex],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
