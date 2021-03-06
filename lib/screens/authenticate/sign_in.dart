import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/services/auth.dart';
import 'package:flutterfirebase/shared/constants.dart';
import 'package:flutterfirebase/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleview;
  SignIn({this.toggleview});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email='';
  String password='';
  String error='';

  final AuthService _authService=AuthService();
  final _formkey= GlobalKey<FormState>();
  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return isLoading?Loading():Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
        actions: [
          FlatButton.icon(onPressed: (){
            widget.toggleview();
          }, icon: Icon(Icons.person,color: Colors.white), label: Text('Register',style:TextStyle(color:Colors.white)))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 20.0),
        child: /*RaisedButton(
          child: Text('Sign in anon'),
          onPressed: ()async{
            dynamic result = await _authService.signInAnon();         //For sign in anonymously
            if(result==null){
              print('error signing in');
            }
            else{
              print('signed in');
              print(result.uid);
            }
          },
        ),*/
      Form(
        key:_formkey,
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
              validator: (value)=>value.length<6?'Enter 6+ char password':null,
              obscureText: true,
              onChanged: (value){
                setState(() {
                  password=value;
                });
              },
            ),
            SizedBox(height: 20.0,),
            RaisedButton(
              child: Text('Sign In'),
              onPressed: ()async{
                if(_formkey.currentState.validate()){
                  setState(()=> isLoading=true);
                  dynamic result = await _authService.signInwEmailnPswd(email, password);
                  if(result==null){
                    setState(() {
                      error= 'Could not signIn with those credentials';
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
      )),
    );
  }
}
