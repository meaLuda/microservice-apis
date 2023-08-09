// models for api
import 'dart:convert';


class Course{
  final int id;
  final String title;
  final String description;

  Course({
    required this.id,
    required this.title,
    required this.description,
  });
}


// List<Lessons> lessonsFromJson(String str) => List<Lessons>.from(json.decode(str).map((x) => Lessons.fromMap(x)));

class Lessons{
  final int id;
  final String title;
  final String description;
  final int courseId;

  Lessons({
    required this.id,
    required this.title,
    required this.description,
    required this.courseId,
  }); 

  // Add the factory constructor 'fromJson' here to convert JSON to Dart object.
  factory Lessons.fromMap(Map<String, dynamic> json) {
   return Lessons(
    id: json['id'] as int,
    title: json['title'] as String,
    description: json['description'] as String,
    courseId: json['course_id'] as int
   );
  }
}


