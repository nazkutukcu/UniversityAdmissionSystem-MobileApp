import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:university_app/services/database.dart';
import 'package:university_app/models/usermodel.dart';
import 'package:university_app/pages/main_screen.dart';

//Source  code:https://www.youtube.com/watch?v=Jy82t4IKJSQ&list=LL&index=3

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //User _userFromFirebaseUser(User user);
  MyUser? _fromFirebaseUser(User user){
  return user!= null? MyUser(uid:user.uid):null ;
  }

  //auth change user stream
  Stream<MyUser?> get user{
    return _auth.authStateChanges().map((User? user) => _fromFirebaseUser(user!));
  }

  //sign in email and password
 Future signIn(String email, String password) async{
   try{    
    UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    User user= result.user!;
    return _fromFirebaseUser(user);        
   }
  catch(e){
    print('AUTH SORUNU:'+e.toString());
    return false;
  }
}
  //register

  Future register(String email, String password,String name,String surname, String ogrenciNo,String telNo,String kimlikNo,String dogumTarihi,String adres,String fakulte,String bolum,String img) async{
   try{    
    UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User user= result.user!;

    //create a new doc for the user with the uid    
    await DatabaseService(uid: user.uid).updateFirebaseUserData(email,password,name,surname,ogrenciNo,telNo,kimlikNo,dogumTarihi,adres,fakulte,bolum,img);
    return _fromFirebaseUser(user);
  }
  catch(e){
    print(e.toString());
    return false;
  }
}

  //sign out
  

    

  }


