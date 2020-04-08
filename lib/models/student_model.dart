import 'package:gti_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Student extends User {
  Student({
    String email,
    String name,
    RoleType role,
    DateTime created,
  }) : super(
          email: email,
          name: name,
          role: role,
          created: created,
        );


  @override
  Student.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  Student.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data);
}
