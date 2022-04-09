import 'package:cloud_firestore/cloud_firestore.dart';

class Iteration {
  Iteration({
    required this.id,
    required this.chart,
    required this.name,
    required this.description,
    required this.ranked,
    required this.content,
    required this.created,
  });

  factory Iteration.fromMap(String id, Map<String, dynamic> data) {
    return Iteration(
      id: id,
      chart: data['chart'],
      name: data['name'],
      description: data['description'],
      ranked: data['ranked'],
      content: data['content'],
      created: data['created'],
    );
  }
  Map<String, dynamic> toJson() => {
        'chart': chart,
        'name': name,
        'description': description,
        'ranked': ranked,
        'content': content,
        'created': created,
      };

  final String id;
  final String chart;
  final String name;
  final String description;
  final bool ranked;
  final Map content;
  final Timestamp created;
}
