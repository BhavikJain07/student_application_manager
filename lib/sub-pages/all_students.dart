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

  Future<void> deleteStudent(String id) async {
    final result = await handleDeleteStudent(id);
    if (result) {
      fetchStudents();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to delete student"),
        ),
      );
    }
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
                title: Text("Application ID: ${_students[index]["id"]}"),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Name: ${_students[index]["firstName"]} ${_students[index]["lastName"]}"),
                    Text("Phone: ${_students[index]["phoneNumber"]}"),
                    Text(
                        "XII: ${_students[index]["xiiPercentage"]} | X: ${_students[index]["xPercentage"]}"),
                    Text(
                        "Selected Departments: ${_students[index]["selectedDepartments"]}"),
                  ],
                ),
                trailing: IconButton(
                    onPressed: () {
                      deleteStudent(_students[index]["id"].toString());
                    },
                    icon: Icon(Icons.delete)),
                onTap: () {},
              );
            },
          ),
        ),
      ],
    );
  }
}
