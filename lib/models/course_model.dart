import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  final String name;
  final String professorId;
  final List<String> attendanceList;
  final String documentId;
  final DateTime created;

  Course({
    this.name,
    this.professorId,
    this.attendanceList,
    this.documentId,
    this.created,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'professorId': professorId,
      'attendanceList': attendanceList,
      'created': created,
    };
  }

  Course.fromMap(Map<String, dynamic> map, String documentId)
      : assert(map['name'] != null),
        name = map['name'],
        professorId = map['professorId'],
        attendanceList = map['attendanceList']?.cast<String>(),
        created = map['created'].toDate(),
        documentId = documentId;

  Course.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, snapshot.documentID);
}
