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

void TestGetData_Modules() async{
  // Add 'async' keyword here
  final apiService = ApiService('https://0365-41-90-68-160.ngrok-free.app');
  try {
    // final fetchedCourses = await apiService.getCourses('api/LearningAPI/v1/courses'); // Use 'await' here
    final fetchedCourses= await apiService.getLessons('api/college_app/v1/all_modules/32'); // Use 'await' here
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

void TestGetData_SubModules() async{
  // Add 'async' keyword here
  final apiService = ApiService('https://0365-41-90-68-160.ngrok-free.app');
  try {
    // final fetchedCourses = await apiService.getCourses('api/LearningAPI/v1/courses'); // Use 'await' here
    final fetchedCourses= await apiService.getLessons('api/college_app/v1/sub_modules/32/4'); // Use 'await' here
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
// void main() {
//   // TestGetData_Modules();
//   TestGetData_SubModules();
// }