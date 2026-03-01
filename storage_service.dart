import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _key = 'user_tasks';

  // Save the entire list of tasks
  Future<void> saveTasks(List<Map<String, dynamic>> tasks) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData = jsonEncode(tasks);
    await prefs.setString(_key, encodedData);
  }

  // Retrieve the list of tasks
  Future<List<Map<String, dynamic>>> getTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedData = prefs.getString(_key);
    
    if (encodedData == null) return [];
    
    List<dynamic> decodedData = jsonDecode(encodedData);
    return decodedData.map((item) => Map<String, dynamic>.from(item)).toList();
  }
}
