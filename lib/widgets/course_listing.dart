import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gti_app/models/course_model.dart';

import 'package:gti_app/sign_in.dart';

class CourseListing extends StatefulWidget {
  @override
  _CourseListingState createState() => _CourseListingState();
}

class _CourseListingState extends State<CourseListing> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('courses')
          .where('professorId', isEqualTo: currentSignedInUser.email)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        }

        return _buildCourseListingItems(
          context,
          snapshot.data.documents,
        );
      },
    );
  }

  Widget _buildCourseListingItems(
    BuildContext context,
    List<DocumentSnapshot> snapshots,
  ) {
    List<Widget> courseWidgetList = List<Widget>();

    snapshots.asMap().forEach((index, data) {
      courseWidgetList.add(_buildcourseCard(data));
    });
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10.0),
              children: courseWidgetList,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildcourseCard(
    DocumentSnapshot data,
  ) {
    final course = Course.fromSnapshot(data);
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Text(course.name, style: TextStyle(color: Colors.black),)
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
      ),
    );
  }
}
