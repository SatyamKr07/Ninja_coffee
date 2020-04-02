import 'package:flutter/material.dart';
import 'package:tnn_ff/services/auth.dart';
import 'package:tnn_ff/shared/constants.dart';
import 'package:tnn_ff/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Ninja Sign Up"),
              backgroundColor: Colors.brown[400],
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () async {
                    //return await _auth.signOut();
                    widget.toggleView();
                  },
                  //color: Colors.orangeAccent,
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
                  disabledColor: Colors.grey,
                  highlightColor: Colors.black38,
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      validator: (value) =>
                          value.isEmpty ? 'Enter email' : null,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      validator: (value) => value.length < 6
                          ? 'Enter password 6+ char long'
                          : null,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          print(email);
                          print(password);
                          setState(() {
                            loading = true;
                          });

                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            print(error);
                            setState(() {
                              error = 'please supply a valid email';
                              print(error);
                              loading = false;
                            });
                          }
                        }
                      },
                      textColor: Colors.white,
                      color: Colors.blueAccent,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.white,
                      highlightColor: Colors.orangeAccent,
                      elevation: 4.0,
                      child: Text('Register'),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
