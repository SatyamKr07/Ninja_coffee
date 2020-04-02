import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tnn_ff/models/brew.dart';
import 'package:tnn_ff/screens/home/brew_list.dart';
import 'package:tnn_ff/screens/home/settings_form.dart';
import 'package:tnn_ff/services/auth.dart';
import 'package:tnn_ff/services/database.dart';

class Home extends StatelessWidget {
  //const Home({Key key}) : super(key: key);
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SettingsForm(),
          );
        },
      );
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ninja Coffee"),
          backgroundColor: Colors.brown[400],
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                return await _auth.signOut();
              },
              //color: Colors.orangeAccent,
              icon: Icon(Icons.person),
              label: Text('logout'),
              disabledColor: Colors.grey,
              highlightColor: Colors.black38,
            ),
            FlatButton.icon(
              onPressed: () {
                //return await _auth.signOut();
                _showSettingsPanel();
              },
              //color: Colors.orangeAccent,
              icon: Icon(Icons.settings),
              label: Text('Settings'),
              disabledColor: Colors.grey,
              highlightColor: Colors.black38,
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/coffee_bg2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
