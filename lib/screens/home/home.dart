import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/models/notes.dart';
import 'package:flutterfirebase/screens/home/edit_notes.dart';
import 'package:flutterfirebase/screens/home/notes_list.dart';
import 'package:flutterfirebase/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutterfirebase/services/database.dart';



class Home extends StatelessWidget {

  final AuthService _auth= AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: NotesEditForm(),
        );
      });
    }
    return StreamProvider<List<Notes>>.value(
      value: DatabaseService().notes,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notes'),
          actions: [
            FlatButton.icon(
                onPressed: () async{
                  await _auth.signOut();
            },
                icon: Icon(Icons.person),
                label:Text('Logout'),
            ),
            FlatButton.icon(onPressed: ()=> _showSettingsPanel(), icon: Icon(Icons.settings), label: Text('Settings'))
          ],
        ),
        body: NotesList(),
      ),
    );
  }
}
