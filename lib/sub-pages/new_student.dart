import 'package:flutter/material.dart';
import 'package:student_application_manager_new/utils/supabase_utils.dart';

class NewStudent extends StatefulWidget {
  const NewStudent({super.key});

  @override
  State<NewStudent> createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {
  final TextEditingController _studentNameTextEditingController =
      TextEditingController();
  final TextEditingController _xiiPercentageTextEditingController =
      TextEditingController();
  final TextEditingController _xPercentageTextEditingController =
      TextEditingController();
  final TextEditingController _selectedDepartmentsTextEditingController =
      TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _studentNameTextEditingController.dispose();
    super.dispose();
  }

  void handleCreateStudent() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      String studentName = _studentNameTextEditingController.text;
      String xiiPercentage = _xiiPercentageTextEditingController.text;
      String xPercentage = _xPercentageTextEditingController.text;
      List<String> selectedDepartments =
          _selectedDepartmentsTextEditingController.text.split(",");
      bool result = await handleCreateNewStudent(
          studentName, xiiPercentage, xPercentage, selectedDepartments);
      if (result) {
        _studentNameTextEditingController.clear();
        _xiiPercentageTextEditingController.clear();
        _xPercentageTextEditingController.clear();
        _selectedDepartmentsTextEditingController.clear();
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Successfully created Student."),
          ),
        );
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error Creating Student"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _studentNameTextEditingController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            label: Text("Student Name"),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: _xiiPercentageTextEditingController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            label: Text("12th Percentage"),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: _xPercentageTextEditingController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            label: Text("10th Percentage"),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: _selectedDepartmentsTextEditingController,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              label: Text("Departments"),
              helper: Text("Enter codes of departments seperated by ','")),
        ),
        SizedBox(
          height: 10,
        ),
        FilledButton(
          onPressed: handleCreateStudent,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: isLoading
                ? CircularProgressIndicator.adaptive()
                : Text("Submit"),
          ),
        ),
      ],
    );
  }
}
