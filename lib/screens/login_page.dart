import 'package:flutter/material.dart';

import 'package:gti_app/colors.dart';
import 'package:gti_app/screens/professor_home_page.dart';
import 'package:gti_app/sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loginInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loginInProgress
          ? LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(paletteForegroundColor),
              backgroundColor: paletteLightGreyColor,
            )
          : Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(decoration: _buildBackgroundDecoration(context)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 100),
                    //_buildBadiUpLogo(),
                    SizedBox(height: 32),
                    _buildLoginButton(context),
                  ],
                ),
              ],
            ),
    );
  }
  void _doLogin(BuildContext context) async {
    setState(() {
      _loginInProgress = true;
    });

    var result = await signInWithGoogle();

    if (result != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return currentSignedInUser.isProfessor()
              ? ProfessorHomePage(professorName: currentSignedInUser.name)
              : Text('STUDENT View');
          },
        ),
      );
    }

    setState(() {
      _loginInProgress = false;
    });
  }

  BoxDecoration _buildBackgroundDecoration(BuildContext context) {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/login_background.jpg'),
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return RaisedButton(
      onPressed: () => _doLogin(context),
      color: paletteBlackColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      highlightElevation: 100,
      child: _buildLoginButtonInternal(),
    );
  }

  Widget _buildLoginButtonInternal() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image(
            image: AssetImage("assets/google_logo.png"),
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              'Google Log In',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: paletteLightGreyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
