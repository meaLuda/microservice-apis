
import 'dart:convert';
import 'package:http/http.dart' as http;


class DataModel {
  final int id;
  final String category;
  final String banner_img_link;

  DataModel({
    required this.id,
    required this.category,
    required this.banner_img_link,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      category: json['name'],
      banner_img_link: json['banner_img_link'],
    );
  }
}

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<dynamic> getCourses(String route) async {
    final response = await http.get(Uri.parse('$baseUrl/$route'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  Future<dynamic> getLessons(String route) async {
    final response = await http.get(Uri.parse('$baseUrl/$route'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['data'];
    } else {
      throw Exception('Failed to load data from API');
    }
  }


}

void TestGetData() async { 
  // Add 'async' keyword here
  final apiService = ApiService('https://4271-41-90-65-164.ngrok-free.app');

  try {
    // final fetchedCourses = await apiService.getCourses('api/LearningAPI/v1/courses'); // Use 'await' here
    final fetchedLessons = await apiService.getLessons('api/LearningAPI/v1/lessons'); // Use 'await' here
    fetchedLessons.forEach((lesson) {
      print("Lesson ${lesson['id']}: ${lesson['title']}");
      print("Description: ${lesson['description']}");
      print("Course ID: ${lesson['course_id']}");
      print("--------------------");
    });
  } catch (e) {
    print('Error: $e');
  }
}

void main() {
  TestGetData();
}
