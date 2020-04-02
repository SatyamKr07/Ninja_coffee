import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tnn_ff/models/user.dart';
import 'package:tnn_ff/screens/wrapper.dart';
import 'package:tnn_ff/services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user, //providing custom user stream from Auth.dart
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
