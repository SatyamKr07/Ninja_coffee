import 'package:flutter/material.dart';
import 'package:tnn_ff/services/auth.dart';
import 'package:tnn_ff/shared/constants.dart';
import 'package:tnn_ff/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
              title: Text("Ninja Sign In"),
              backgroundColor: Colors.brown[400],
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    //return await _auth.signOut();
                    widget.toggleView();
                  },
                  //color: Colors.orangeAccent,
                  icon: Icon(Icons.person),
                  label: Text('Register'),
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
                        // dynamic result = await _auth.signInAnon();
                        // //dynamic since result can be user or null.
                        // if (result == null) {
                        //   print("error signing in");
                        // } else {
                        //   print('user signed in');
                        //   print(result.uid);
                        // }
                        if (_formKey.currentState.validate()) {
                          print(email);
                          print(password);
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth.signInEmailAndPassword(
                              email, password);
                          if (result == null) {
                            setState(() {
                              error = "can't sign in with these credentials";
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
                      child: Text('SignIn'),
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
