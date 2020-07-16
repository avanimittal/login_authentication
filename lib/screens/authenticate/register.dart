import 'package:flutter/material.dart';
import 'package:flutterfirebase/services/auth.dart';
import 'package:flutterfirebase/shared/constants.dart';
import 'package:flutterfirebase/shared/loading.dart';


class Register extends StatefulWidget {
  final Function toggleview;
  Register({this.toggleview});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email='';
  String password='';
  String error='';

  final AuthService _authService=AuthService();
  final _formkey=GlobalKey<FormState>();
  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return isLoading?Loading():Scaffold(
        appBar: AppBar(
        title: Text('Register'),
          actions: [
            FlatButton.icon(onPressed: (){
              widget.toggleview();
            }, icon: Icon(Icons.person,color: Colors.white,), label: Text('Sign In',style: TextStyle(color: Colors.white),))
          ],
    ),
    body:Container(
      padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 20.0),
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            SizedBox(height: 20.0,),
            TextFormField(
              decoration:textInputDecoration.copyWith(hintText: 'Enter Email',labelText: 'Email'),
              validator: (value)=>value.isEmpty?'Enter an email':null,
              onChanged: (value){
                setState(() {
                  email=value;
                });
              },
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              decoration:textInputDecoration.copyWith(hintText: 'Enter Password',labelText: 'Password'),
              validator: (value)=>value.length <6?'Enter 6+ char long password':null,
              obscureText: true,
              onChanged: (value){
                setState(() {
                  password=value;
                });
              },
            ),
            SizedBox(height: 20.0,),
            RaisedButton(
              child: Text('Register'),
              onPressed: ()async{
                if(_formkey.currentState.validate()){
                  setState(()=>isLoading=true);
                  dynamic result = await _authService.registerwEmailnPswd(email, password);
                  if(result==null){
                    setState(() {
                     error= 'Please supply valid email';
                     isLoading=false;
                    });
                  }
                }
              },
            ),
            SizedBox(height:20.0),
            Text(error, style: TextStyle(color: Colors.red,fontSize: 14.0),)
          ],
        ),
      ),
    ),
    );
  }
}
