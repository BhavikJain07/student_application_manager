import 'package:flutter/material.dart';
import 'package:student_application_manager_new/utils/supabase_utils.dart';

class NewStudent extends StatefulWidget {
  const NewStudent({super.key});

  @override
  State<NewStudent> createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {
  final TextEditingController _firstNameTextEditingController =
      TextEditingController();
  final TextEditingController _lastNameTextEditingController = TextEditingController();
  final TextEditingController _phoneNumberTextEditingController =
      TextEditingController();
  final TextEditingController _addressTextEditingController = TextEditingController();
  final TextEditingController _xiiPercentageTextEditingController =
      TextEditingController();
  final TextEditingController _xPercentageTextEditingController =
      TextEditingController();
  final TextEditingController _selectedDepartmentsTextEditingController =
      TextEditingController();
  bool isLoading = false;
  bool gender = false;
  bool hostelRequired = false;

  @override
  void dispose() {
    _firstNameTextEditingController.dispose();
    _lastNameTextEditingController.dispose();
    _phoneNumberTextEditingController.dispose();
    _addressTextEditingController.dispose();
    _xiiPercentageTextEditingController.dispose();
    _xPercentageTextEditingController.dispose();
    _selectedDepartmentsTextEditingController.dispose();
    super.dispose();
  }

  void handleCreateStudent() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      String firstName = _firstNameTextEditingController.text.trim();
      String lastName = _lastNameTextEditingController.text.trim();
      String phoneNumber = _phoneNumberTextEditingController.text.trim();
      String address = _addressTextEditingController.text.trim();
      String xiiPercentage = _xiiPercentageTextEditingController.text.trim();
      String xPercentage = _xPercentageTextEditingController.text.trim();
      List<String> selectedDepartments =
          _selectedDepartmentsTextEditingController.text.split(",");
      bool result = await handleCreateNewStudent(
        firstName,
        lastName,
        xiiPercentage,
        xPercentage,
        phoneNumber,
        address,
        gender,
        hostelRequired,
        selectedDepartments,
      );
      if (result) {
        _firstNameTextEditingController.clear();
        _lastNameTextEditingController.clear();
        _xiiPercentageTextEditingController.clear();
        _xPercentageTextEditingController.clear();
        _phoneNumberTextEditingController.clear();
        _addressTextEditingController.clear();
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
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _firstNameTextEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  label: Text("First Name"),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _lastNameTextEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  label: Text("Last Name"),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _xiiPercentageTextEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  label: Text("12th Percentage"),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _xPercentageTextEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  label: Text("10th Percentage"),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _phoneNumberTextEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  label: Text("Phone Number"),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: TextField(
                controller: _addressTextEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  label: Text("Address"),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Gender: ${gender ? "Male" : "Female"}"),
                  SizedBox(
                    width: 10,
                  ),
                  Switch(
                    value: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            gender ? Text("Hostel Needed:") : SizedBox(),
            gender
                ? SizedBox(
                    width: 10,
                  )
                : SizedBox(),
            gender
                ? Switch(
                    value: hostelRequired,
                    onChanged: (value) {
                      setState(() {
                        hostelRequired = value;
                      });
                    },
                  )
                : SizedBox()
          ],
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
