import 'package:flutter/material.dart';
import 'package:flutterfirebase/models/userobject.dart';
import 'package:flutterfirebase/screens/authenticate/authenticate.dart';
import 'package:flutterfirebase/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserObject>(context);
    if(user==null){
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}
