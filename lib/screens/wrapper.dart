import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tnn_ff/models/user.dart';
import 'package:tnn_ff/screens/authenticate/authenticate.dart';
import 'package:tnn_ff/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    //return either Home or Authenticate widget based on user object value.
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
