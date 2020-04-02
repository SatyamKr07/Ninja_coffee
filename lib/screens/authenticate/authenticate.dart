import 'package:flutter/material.dart';
import 'package:tnn_ff/screens/authenticate/register.dart';
import 'package:tnn_ff/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  Authenticate({Key key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isSignIn = true;
  void toggle() {
    setState(() {
      isSignIn = !isSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isSignIn) {
      return SignIn(toggleView: toggle);
      //toggleView is a parameter->define in SignIn consturctor
    } else {
      return Register(toggleView: toggle);
    }
  }
}
