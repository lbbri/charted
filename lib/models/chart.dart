import 'package:cloud_firestore/cloud_firestore.dart';

class Chart {
  Chart(
      {required this.id,
      required this.lIteration,
      required this.user,
      required this.created});

  factory Chart.fromMap(String id, Map<String, dynamic> data) {
    return Chart(
      id: id,
      lIteration: data['last_iteration'],
      user: data['user'],
      created: data['created'],
    );
  }
  Map<String, dynamic> toJson() => {
        'last_iteration': lIteration,
        'user': user,
        'created': created,
      };

  final String id;
  final String lIteration;
  final String user;
  final Timestamp created;
}
