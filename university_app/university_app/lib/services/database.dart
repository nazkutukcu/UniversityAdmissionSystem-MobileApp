import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService{

  final String uid;
  DatabaseService({required this.uid});

   //UPDATE Firebase User Information Data
  final CollectionReference userDataCollection=FirebaseFirestore.instance.collection('users');  

  Future updateFirebaseUserData(String email, String password,String name,String surname, String ogrenciNo,String telNo,String kimlikNo,String dogumTarihi,String adres,String fakulte,String bolum,String img)async{
    return await userDataCollection.doc(uid).set({
      'name':name,
      'surname':surname,
      'ogrenciNo':ogrenciNo,
      'telNo':telNo,
      'kimlikNo':kimlikNo,
      'dogumTarihi':dogumTarihi,
      'adres':adres,
      'fakulte':fakulte,
      'bolum':bolum,
      'email':email,
      'password':password,
      'img':img,
    });
  }

  
  
}