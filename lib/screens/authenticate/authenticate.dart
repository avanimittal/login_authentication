import 'package:flutter/material.dart';
import 'package:flutterfirebase/screens/authenticate/register.dart';
import 'package:flutterfirebase/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showsignIn= true;
  void toggleview(){
    setState(() {
      showsignIn=!showsignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showsignIn){
      return SignIn(toggleview: toggleview);
    }
    else{
      return Register(toggleview: toggleview);
    }
  }
}
