import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';


class Storage{
    final firebase_storage.FirebaseStorage storage=
    firebase_storage.FirebaseStorage.instance;

      Future <void> UploadFile(
          String filePath,
          String fileName,
        )async{
          File file=File(filePath);

        try {
          await storage.ref('usersImages/$fileName').putFile(file);          
           
        }on firebase_core.FirebaseException catch (e) {
          print(e);
        }        
      }

      Future <void> UploadPdfFile(
          String filePath,
          String fileName,
        )async{
          File file=File(filePath);
        try {
          await storage.ref('basvurular/$fileName').putFile(file);          
           
        }on firebase_core.FirebaseException catch (e) {
          print(e);
        }
      }

      //Upload Yaz okulu basvuruları in firestore
      final CollectionReference applyDataCollection=FirebaseFirestore.instance.collection('yazokulubasvurular');

      Future setApplyData(String name, String ogrenciNo,String kimlikNo,String telNo, String email,String adres,String alinanDers,String fakulte,String bolum,String pdfFile)async{
        return await applyDataCollection.doc().set({      
          'name':name,
          'ogrenciNo':ogrenciNo,
          'kimlikNo':kimlikNo,
          'telNo':telNo,
          'email':email,
          'adres':adres,
          'alinanDers':alinanDers,
          'fakulte':fakulte,
          'bolum':bolum,   
          'pdfFile': pdfFile,  
        });
      }

      //Upload Cap Basvuruları in firestore
      final CollectionReference applyDataCollectionCap=FirebaseFirestore.instance.collection('capbasvurular');
      Future setApplyDataCap(String name, String ogrenciNo,String kimlikNo,String telNo, String email,String adres,String basvurulanBolum,String fakulte,String bolum,String pdfFile)async{
        return await applyDataCollectionCap.doc().set({      
          'name':name,
          'ogrenciNo':ogrenciNo,
          'kimlikNo':kimlikNo,
          'telNo':telNo,
          'email':email,
          'adres':adres,
          'basvurulanBolum':basvurulanBolum,
          'fakulte':fakulte,
          'bolum':bolum,   
          'pdfFile': pdfFile,  
        });
      }

      //Upload İntibak Basvuruları in firestore
      final CollectionReference applyDataCollectionIntibak=FirebaseFirestore.instance.collection('intibakbasvurular');
      Future setApplyDataIntibak(String name, String ogrenciNo,String kimlikNo,String telNo, String email,String adres,String muafDers,String fakulte,String bolum,String pdfFile)async{
        return await applyDataCollectionIntibak.doc().set({      
          'name':name,
          'ogrenciNo':ogrenciNo,
          'kimlikNo':kimlikNo,
          'telNo':telNo,
          'email':email,
          'adres':adres,
          'muafDers':muafDers,
          'fakulte':fakulte,
          'bolum':bolum,   
          'pdfFile': pdfFile,  
        });
      }

      //Upload DGS Basvuruları in firestore
      final CollectionReference applyDataCollectionDgs=FirebaseFirestore.instance.collection('dgsbasvurular');
      Future setApplyDataDgs(String name, String ogrenciNo,String kimlikNo,String telNo, String email,String adres,String notOrt,String fakulte,String bolum,String pdfFile)async{
        return await applyDataCollectionDgs.doc().set({      
          'name':name,
          'ogrenciNo':ogrenciNo,
          'kimlikNo':kimlikNo,
          'telNo':telNo,
          'email':email,
          'adres':adres,
          'notOrt':notOrt,
          'fakulte':fakulte,
          'bolum':bolum,   
          'pdfFile': pdfFile,  
        });
      }

      //Upload Yatay Gecis Basvuruları in firestore
      final CollectionReference applyDataCollectionYGecis=FirebaseFirestore.instance.collection('ygecisbasvurular');
      Future setApplyDataYGecis(String name, String ogrenciNo,String kimlikNo,String telNo, String email,String adres,String notOrt,String fakulte,String bolum,String pdfFile)async{
        return await applyDataCollectionYGecis.doc().set({      
          'name':name,
          'ogrenciNo':ogrenciNo,
          'kimlikNo':kimlikNo,
          'telNo':telNo,
          'email':email,
          'adres':adres,
          'notOrt':notOrt,
          'fakulte':fakulte,
          'bolum':bolum,   
          'pdfFile': pdfFile,  
        });
      }
}