import 'package:flutter/material.dart';
import 'package:student_application_manager_new/utils/supabase_utils.dart';

class AllStudents extends StatefulWidget {
  const AllStudents({super.key});

  @override
  State<AllStudents> createState() => _AllStudentsState();
}

class _AllStudentsState extends State<AllStudents> {
  List<Map> _students = [];

  @override
  void initState() {
    fetchStudents();
    super.initState();
  }

  Future<void> fetchStudents() async {
    final students = await fetchAllStudents();
    setState(() {
      _students = students;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("All Students"),
        Expanded(
          child: ListView.builder(
            itemCount: _students.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  _students[index]["id"].toString(),
                ),
                subtitle: Text("Student Name: ${_students[index]["firstName"].toString()} | XII: ${_students[index]["xiiPercentage"].toString()} | X: ${_students[index]["xPercentage"].toString()} | ${_students[index]["selectedDepartments"].toString()}"),
              );
            },
          ),
        ),
      ],
    );
  }
}
