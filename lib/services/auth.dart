import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfirebase/models/userobject.dart';
import 'package:flutterfirebase/services/database.dart';

class AuthService{

  final FirebaseAuth _auth=FirebaseAuth.instance;

//create user object from firebase user
  UserObject _userObjectFromFirebase(FirebaseUser user){
    return user!=null?UserObject(uid: user.uid):null;
  }
//auth change user streams
  Stream<UserObject> get user {
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user)=>_userObjectFromFirebase(user));
    .map(_userObjectFromFirebase);    //Another method for the above solution
  }
  //sign in using anonymous
  Future signInAnon() async{
    try{
      AuthResult result= await _auth.signInAnonymously();
      FirebaseUser user=result.user;
      return _userObjectFromFirebase(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

//sign in using email and password
  Future signInwEmailnPswd(String email, String password) async{
    try{
      AuthResult result= await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user =result.user;
      return _userObjectFromFirebase(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

//register
  Future registerwEmailnPswd(String email, String password) async{
    try{
      AuthResult result= await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user =result.user;
      await DatabaseService(uid:user.uid).updateUserData('No Subject','New User',0);
      return _userObjectFromFirebase(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

//sign out
Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
}
}