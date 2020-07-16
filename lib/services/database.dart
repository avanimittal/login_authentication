import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfirebase/models/notes.dart';
import 'package:flutterfirebase/models/userobject.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference notesCollection= Firestore.instance.collection('notes');

  Future updateUserData (String subject, String name, int chapters) async{
    return await notesCollection.document(uid).setData({
      'subject': subject,
      'name': name,
      'chapters':chapters,
    });
  }
  //notes list from snapshot
  List<Notes> _notesListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Notes(
        name: doc.data['name']??'',
        subject: doc.data['subject']??'',
        chapters: doc.data['chapters']??0,
      );
    }).toList();
  }
  //userData from Snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      chapters: snapshot.data['chapters'],
      subject: snapshot.data['subject'],
    );
  }
  //get notes stream
  Stream<List<Notes>> get notes{
    return notesCollection.snapshots()
        .map(_notesListFromSnapshot);
  }
  //get user data stream
  Stream <UserData> get userData{
    return notesCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }
}