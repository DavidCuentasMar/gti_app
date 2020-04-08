import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:gti_app/models/user_model.dart';

class Professor extends User {
  Professor({
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
  Professor.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  Professor.fromSnapshot(DocumentSnapshot snapshot) : super.fromMap(snapshot.data);
}
