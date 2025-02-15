import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<PostgrestList> fetchAllStudents() async {
  final data = await supabase.from("students").select();
  return data;
}

Future<bool> handleCreateNewStudent(
    String firstName,
    String lastName,
    String xiiPercentage,
    String xPercentage,
    String phone,
    String address,
    bool gender,
    bool hostelRequired,
    List<String> selectedDepartments) async {
  try {
    await supabase.from("students").insert({
      "firstName": firstName,
      "lastName": lastName,
      "xiiPercentage": xiiPercentage,
      "xPercentage": xPercentage,
      "phoneNumber": phone,
      "address": address,
      "gender": gender,
      "hostelRequired": hostelRequired,
      "selectedDepartments": selectedDepartments,
    });
  } catch (error) {
    return false;
  }
  return true;
}

Future<PostgrestList> fetchFilteredStudents(
    String searchQuery, bool rankFilter) async {
  if (rankFilter) {
    final data = await supabase
        .from("students")
        .select()
        .order("xiiPercentage", ascending: false)
        .order("xPercentage", ascending: false);
    final filteredData = data.where((i) {
      return i["selectedDepartments"].contains(searchQuery);
    }).toList();
    return filteredData;
  } else {
    final data = await supabase.from("students").select();
    final filteredData = data.where((i) {
      return i["selectedDepartments"].contains(searchQuery);
    }).toList();
    return filteredData;
  }
}

Future<bool> handleDeleteStudent(String id) async {
  try {
    await supabase.from("students").delete().eq("id", id);
    return true;
  } catch (error) {
    return false;
  }
}
