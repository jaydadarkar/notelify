import 'package:Notelify/service/auth.dart';
import 'package:flutter/material.dart';

class MyAccount extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthServiceProvider _auth = AuthServiceProvider();

  final RegExp _emailRegex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  void delete() {}
  void clear() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Sign In / Register',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.teal,
        ),
        backgroundColor: Colors.teal,
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Material(
                  elevation: 10,
                  child: Image.asset(
                    'lib/assets/images/logo.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Form(
                  key: _formKey,
                  autovalidate: false,
                  child: Container(
                    margin: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(4),
                              child: TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  hintStyle: TextStyle(color: Colors.black54),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(10),
                                  border: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(20),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(fontSize: 20),
                                autofocus: true,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Email Cannot Be Empty';
                                  } else {
                                    if (!_emailRegex.hasMatch(value)) {
                                      return 'Invalid Email';
                                    }
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  prefixIcon: Icon(Icons.lock),
                                  hintStyle: TextStyle(color: Colors.black54),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(20),
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 20),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Password Cannot Be Empty';
                                  } else {
                                    if (value.length < 8) {
                                      return 'Password Too Week';
                                    }
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: FlatButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                ButtonTheme(
                                    minWidth: 100,
                                    height: 50,
                                    child: Builder(
                                        builder: (context) => RaisedButton(
                                              child: Text(
                                                'Sign In',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              color: Colors.white,
                                              textColor: Colors.teal,
                                              onPressed: () async {
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  print('Valid Input');
                                                  final dynamic user =
                                                      await _auth.signIn(
                                                          _emailController.text,
                                                          _passwordController
                                                              .text);
                                                  if (user == 500) {
                                                    Scaffold.of(context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Incorrect Email / Password.'),
                                                      duration:
                                                          Duration(seconds: 5),
                                                    ));
                                                    print(
                                                        'Wrong Email Or Password');
                                                  } else {
                                                    print(user);
                                                  }
                                                } else {
                                                  print('Invalid Input');
                                                }
                                              },
                                            ))),
                                ButtonTheme(
                                    minWidth: 150,
                                    height: 50,
                                    child: Builder(
                                      builder: (context) => RaisedButton(
                                        child: Text(
                                          'Register',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        color: Colors.white,
                                        textColor: Colors.teal,
                                        onPressed: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            print('Valid Input');
                                            final dynamic user =
                                                await _auth.register(
                                                    _emailController.text,
                                                    _passwordController.text);
                                            if (user == 500) {
                                              Scaffold.of(context)
                                                  .showSnackBar(SnackBar(
                                                content:
                                                    Text('Unable To Register.'),
                                                duration: Duration(seconds: 5),
                                              ));
                                              print('Unable To Register');
                                            } else {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: new Text(
                                                          'Welcome !!'),
                                                      content: new Text(
                                                          'You have registered successfully.'),
                                                      actions: [
                                                        new FlatButton(
                                                            onPressed:
                                                                Navigator.of(
                                                                        context)
                                                                    .pop,
                                                            child: new Text(
                                                                "Close"))
                                                      ],
                                                    );
                                                  });
                                              print(user.uid);
                                            }
                                          } else {
                                            print('Invalid Input');
                                          }
                                        },
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
