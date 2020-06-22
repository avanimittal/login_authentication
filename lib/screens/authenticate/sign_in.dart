import 'package:flutter/material.dart';
import 'package:flutterfirebase/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService=AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: Container(
        child: RaisedButton(
          child: Text('Sign in anon'),
          onPressed: ()async{
            dynamic result = await _authService.signInAnon();
            if(result==null){
              print('error signing in');
            }
            else{
              print('signed in');
              print(result.uid);
            }
          },
        ),
      ),
    );
  }
}
