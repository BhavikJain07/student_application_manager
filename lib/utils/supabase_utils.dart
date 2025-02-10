import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<PostgrestList> fetchAllStudents() async {
  final data = await supabase.from("students").select();
  return data;
}

Future<bool> handleCreateNewStudent(String studentName, String xiiPercentage,
    String xPercentage, List<String> selectedDepartments) async {
  if (studentName.isEmpty || studentName == "") {
    return false;
  }
  if (xiiPercentage.isEmpty || xiiPercentage == "") {
    return false;
  }
  if (xPercentage.isEmpty || xPercentage == "") {
    return false;
  }
  if (selectedDepartments.isEmpty) {
    return false;
  }
  await supabase.from("students").insert({
    "student_name": studentName.toString().trim(),
    "xii_percentage": xiiPercentage.toString().trim(),
    "x_percentage": xPercentage.toString().trim(),
    "selectedDepartments": selectedDepartments,
  });
  return true;
}

Future<PostgrestList> fetchFilteredStudents(
    String searchQuery, bool rankFilter) async {
  if (rankFilter) {
    final data = await supabase
        .from("students")
        .select()
        .order("xii_percentage", ascending: false)
        .order("x_percentage", ascending: false);
    final filteredData = data.where((element) {
      return element["selectedDepartments"]
          .toString()
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();
    return filteredData;
  } else {
    final data = await supabase.from("students").select();
    final filteredData = data.where((element) {
      return element["selectedDepartments"]
          .toString()
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();
    return filteredData;
  }
}
