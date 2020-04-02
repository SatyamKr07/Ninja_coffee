import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tnn_ff/models/user.dart';
import 'package:tnn_ff/services/database.dart';
import 'package:tnn_ff/shared/constants.dart';
import 'package:tnn_ff/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  SettingsForm({Key key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  //form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Update your Settings here",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto",
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.name,
                  validator: (val) {
                    return val.isEmpty ? 'Please enter your name' : null;
                  },
                  onChanged: (val) {
                    setState(() {
                      _currentName = val; //declare String _currentName above
                    });
                  },
                  style: TextStyle(color: Colors.black),
                  obscureText: false, // Use true to secure text for passwords.
                  decoration: textInputDecoration,
                ),
                SizedBox(height: 20.0),
                //DropDown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData.sugars,
                  items: sugars.map((sugars) {
                    //sugars is a list above.
                    //eg final List<String> sugars = ['0', '1', '2', '3', '4'];
                    return DropdownMenuItem(
                      value: sugars,
                      child: Text('$sugars sugars'),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _currentSugars = val;
                    });
                  },
                ),
                //slider
                Slider(
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor:
                      Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor:
                      Colors.brown[_currentStrength ?? userData.strength],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) {
                    setState(() {
                      _currentStrength = val.round();
                      //round as _currentStrength is int
                    });
                  },
                ),
                RaisedButton(
                  onPressed: () async {
                    // print(_currentName);
                    // print(_currentSugars);
                    // print(_currentStrength);
                    await DatabaseService(uid: user.uid).updateUserData(
                      _currentSugars ?? userData.sugars,
                      _currentName ?? userData.name,
                      _currentStrength ?? userData.strength,
                    );
                    Navigator.pop(context);
                  },
                  textColor: Colors.white,
                  color: Colors.blueAccent,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.white,
                  highlightColor: Colors.orangeAccent,
                  elevation: 4.0,
                  child: Text('Raised Button'),
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
