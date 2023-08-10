import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'models.dart';


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

void TestGetData_Courses() async{
  // Add 'async' keyword here
  final apiService = ApiService('https://477e-41-90-64-234.ngrok-free.app');
  try {
    // final fetchedCourses = await apiService.getCourses('api/LearningAPI/v1/courses'); // Use 'await' here
    final fetchedCourses= await apiService.getLessons('api/LearningAPI/v1/courses'); // Use 'await' here
    print(fetchedCourses);
    // fetchedLessons.forEach((lesson) {
    //   print("Lesson ${lesson['id']}: ${lesson['title']}");
    //   print("Description: ${lesson['description']}");
    //   print("Course ID: ${lesson['course_id']}");
    //   print("\n ------------------------------------------ \n");
    // });
  } catch (e) {
    print('Error: $e');
  }
}





void TestGetData_Lessons() async { 
  // Add 'async' keyword here
  final apiService = ApiService('https://477e-41-90-64-234.ngrok-free.app');

  try {
    // final fetchedCourses = await apiService.getCourses('api/LearningAPI/v1/courses'); // Use 'await' here
    final fetchedLessons = await apiService.getLessons('api/LearningAPI/v1/lessons'); // Use 'await' here
    fetchedLessons.forEach((lesson) {
      print("Lesson ${lesson['id']}: ${lesson['title']}");
      print("Description: ${lesson['description']}");
      print("Course ID: ${lesson['course_id']}");
      print("\n ------------------------------------------ \n");
    });
  } catch (e) {
    print('Error: $e');
  }
}

// void main() {
//   TestGetData_Courses();
// }