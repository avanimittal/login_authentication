import'package:flutter/material.dart';
import 'package:flutterfirebase/models/userobject.dart';
import 'package:flutterfirebase/services/database.dart';
import'package:flutterfirebase/shared/constants.dart';
import 'package:flutterfirebase/shared/loading.dart';
import 'package:provider/provider.dart';

class NotesEditForm extends StatefulWidget {
  @override
  _NotesEditFormState createState() => _NotesEditFormState();
}

class _NotesEditFormState extends State<NotesEditForm> {
  final _formKey =GlobalKey<FormState>();
  final List<String> subjects= ['OS', 'TAFL', 'WEBD', 'MATHS4', 'UHV'];
  final List<int> chapters= [0,1,2,3,4,5];

  String _currentName;
  String _subjects;
  int _chapters;

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserObject>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData= snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text('Update your notes status',style: TextStyle(fontSize: 20.0),),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration.copyWith(hintText: 'Name of student',labelText: 'Name'),
                    validator: (val)=>val.isEmpty?'Please enter this field':null,
                    onChanged: (val)=> setState(()=> _currentName=val),
                  ),
                  SizedBox(height:20.0),
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _subjects??userData.subject,
                    items: subjects.map((subject){
                      return DropdownMenuItem(
                        value: subject,
                        child: Text('$subject'),
                      );
                    }).toList(),
                    onChanged: (val)=> setState(()=> _subjects=val),
                  ),
                  SizedBox(height: 20.0,),
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _chapters??userData.chapters,
                    items: chapters.map((chapter){
                      return DropdownMenuItem(
                        value: chapter,
                        child: Text('$chapter'),
                      );
                    }).toList(),
                    onChanged: (val)=> setState(()=> _chapters=val),
                  ),
                  SizedBox(height:20.0),
                  RaisedButton(
                    color: Colors.blue,
                    child: Text('Update',style: TextStyle(color: Colors.white),),
                    onPressed: ()async{
                      if(_formKey.currentState.validate()){
                        await DatabaseService(uid: user.uid).updateUserData(_subjects??userData.subject,_currentName??userData.name,_chapters??userData.chapters);
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            );
        }else{
          return Loading();
        }

      }
    );
  }
}
