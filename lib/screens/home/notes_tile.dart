import 'package:flutter/material.dart';
import 'package:flutterfirebase/models/notes.dart';

class NotesTile extends StatelessWidget {
  final Notes note;
  NotesTile({this.note});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.blue,
            child: Text('${note.chapters}',style: TextStyle(color: Colors.white),),
          ),
          title: Text(note.name),
          subtitle: Text(note.subject),
         ),
      ),
    );
  }
}
