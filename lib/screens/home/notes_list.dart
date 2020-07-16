import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfirebase/models/notes.dart';
import 'package:flutterfirebase/screens/home/notes_tile.dart';
import 'package:provider/provider.dart';

class NotesList extends StatefulWidget {
  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  @override
  Widget build(BuildContext context) {

    final notes=Provider.of<List<Notes>>(context)??[];

    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context,index){
        return NotesTile(note:notes[index]);
      },
    );
  }
}
