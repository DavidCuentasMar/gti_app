import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String name;
  final RoleType role;
  final DateTime created;

  User({
    this.email,
    this.name,
    this.role,
    this.created,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'role': role.index,
      'created': created,
    };
  }

  bool isProfessor() {
    return (role == RoleType.professor);
  }

  User.fromMap(Map<String, dynamic> map)
      : assert(map['email'] != null),
        assert(map['name'] != null),
        assert(map['role'] != null),
        email = map['email'],
        name = map['name'],
        role = RoleType.values[map['role']],
        created = map['created'].toDate();

  User.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data);
}

enum RoleType {
  professor, // 0
  student, // 1
}
