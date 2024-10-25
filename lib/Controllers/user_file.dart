import 'package:womentaxi/untils/export_file.dart';

class User {
  final String userId;
  final String socketId;

  User({required this.userId, required this.socketId});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'],
      socketId: map['socketId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'socketId': socketId,
    };
  }
}
