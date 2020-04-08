import 'package:flutter/material.dart';
import 'package:gti_app/models/course_model.dart';
import 'package:gti_app/widgets/course_listing.dart';
import 'package:gti_app/constants.dart' as constants;
import '../sign_in.dart';

class ProfessorHomePage extends StatefulWidget {
  ProfessorHomePage({Key key, this.professorName}) : super(key: key);

  final String professorName;
  @override
  ProfessorHomePageState createState() => ProfessorHomePageState();
}

class ProfessorHomePageState extends State<ProfessorHomePage> {
  String _newCourseName;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: CourseListing(),
      //drawer: _buildDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddCourseModal(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }

  void showAddCourseModal(BuildContext context) {
    Dialog fancyDialog = Dialog(
      child: Container(
        width: 300.0,
        child: Wrap(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Text(
                "New Course",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(12.0),
              width: 300,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Course Name'),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Course Name Required';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        _newCourseName = value;
                      },
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.grey[300]),
              padding: EdgeInsets.all(12),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      child: Container(
                        child: Text('Cancel'),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      child: Container(
                        child: Text('Save'),
                      ),
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          addnewCourse(this._newCourseName);
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => fancyDialog);
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Professor: " + widget.professorName),
      centerTitle: true,
      //actions: <Widget>[
      //CartButton(),
      //],
    );
  }

  Future<void> addnewCourse(String newCourseName) async {
    Course course = Course(
        name: newCourseName,
        professorId: currentSignedInUser.email,
        attendanceList: [],
        created: DateTime.now().toUtc());
    await db
        .collection(constants.DBCollections.courses)
        .document()
        .setData(course.toMap());
  }

  // Widget _buildDrawer() {
  //   double width = MediaQuery.of(context).size.width;
  //   final scaffoldKey = GlobalKey<ScaffoldState>();
  //   return SizedBox(
  //     width: width * 0.7,
  //     child: Drawer(
  //       key: scaffoldKey,
  //       child: MainMenu(),
  //     ),
  //   );
  // }
}
