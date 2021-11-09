import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:university_app/services/auth.dart';
import 'package:university_app/shared/constants.dart';
import 'package:university_app/services/storage_services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:university_app/services/database.dart';

class Yataygecis extends StatefulWidget {
  const Yataygecis({Key? key}) : super(key: key);

  @override
  _YataygecisState createState() => _YataygecisState();
}

class _YataygecisState extends State<Yataygecis> {
  final AuthService _auth = AuthService();

  String name = '';
  String ogrenciNo = '';
  String kimlikNo = '';
  String telNo = '';
  String email = '';
  String adres = '';
  String notOrt='';
  String fakulte = '';
  String bolum = '';
  String pdfFile = '';
  String textMessage='';

  var fileController='';
  var selectedbla;
  var gelenYaziBasligi = "";
  var gelenYaziIcerigi = "";
  get floatingActionButton => null;
  var selectedCurrency, selectedType;
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  TextEditingController t1 = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  get primaryColor => null;

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    var list = "";
    var instance = "";
    int _counter = 0;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'YATAY GEÇİŞ BAŞVURU FORMU ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 5),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Ad Soyad',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? 'Ad soyad giriniz' : null,
                    onChanged: (val) {
                      setState(() => name = val);
                    },
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 300,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Öğrenci Numarası',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? 'Öğrenci no giriniz' : null,
                    onChanged: (val) {
                      setState(() => ogrenciNo = val);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 300,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'TC Kimlik Numarası',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? 'Kimlik no giriniz' : null,
                    onChanged: (val) {
                      setState(() => kimlikNo = val);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 300,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Telefon Numarası',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    validator: (val) => val!.isEmpty ? 'Tel no giriniz' : null,
                    onChanged: (val) {
                      setState(() => telNo = val);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 300,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'E-posta',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    validator: (val) => val!.isEmpty ? 'E-posta giriniz' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 300,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Adres',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    validator: (val) => val!.isEmpty ? 'Adres giriniz' : null,
                    onChanged: (val) {
                      setState(() => adres = val);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 300,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Öğrencinin Genel Not Ortalamanız (GNO)',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? 'not ortalamanızı giriniz' : null,
                    onChanged: (val) {
                      setState(() => notOrt = val);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //dropdown1
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('fakulteler')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        List<DropdownMenuItem<String>> currencyItems = [];
                        for (int i = 0; i < snapshot.data!.docs.length; i++) {
                          DocumentSnapshot snap = snapshot.data!.docs[i];
                          currencyItems.add(
                            DropdownMenuItem(
                              child: Text(
                                snap.id,
                                style: TextStyle(color: Color(0xFF000000)),
                              ),
                              value: "${snap.id}",
                            ),
                          );
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(width: 50.0),
                            DropdownButton<String>(
                              items: currencyItems,
                              onChanged: (currencyValue) {
                                final snackBar = SnackBar(
                                  content: Text(
                                    'Selected Currency value is $currencyValue',
                                    style: TextStyle(color: Color(0xFF000000)),
                                  ),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                                setState(() {
                                  selectedCurrency = currencyValue;
                                  fakulte = selectedCurrency;
                                });
                              },
                              value: selectedCurrency,
                              isExpanded: false,
                              hint: new Text(
                                "Fakültenizi Seçiniz",
                                style: TextStyle(color: Color(0xFF000000)),
                              ),
                            ),
                          ],
                        );
                      }
                    }),
                SizedBox(
                  height: 20,
                ),

                //dropdown2
                 StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('bolumler')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      
                      else {
                        List<DropdownMenuItem<String>> blaItems = [];
                        for (int i = 0; i < snapshot.data!.docs.length; i++) {
                          DocumentSnapshot snap = snapshot.data!.docs[i];
                          blaItems.add(
                            DropdownMenuItem(
                              child: Text(
                                snap.id,
                                style: TextStyle(color: Color(0xFF000000)),
                              ),
                              value: "${snap.id}",
                            ),
                          );
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(width: 50.0),
                            DropdownButton<String>(
                              items: blaItems,
                              onChanged: (blaValue) {
                                final snackBar = SnackBar(
                                  content: Text(
                                    'Selected Currency value is $blaValue',
                                    style: TextStyle(color: Color(0xFF000000)),
                                  ),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                                setState(() {
                                  selectedbla = blaValue;
                                  bolum=selectedbla;
                                });
                              },
                              value: selectedbla,
                              isExpanded: false,
                              hint: new Text(
                                "Bölümünüzü  Seçiniz",
                                style: TextStyle(color: Color(0xFF000000)),
                              ),
                            ),
                          ],
                        );
                      }
                    }),
                SizedBox(
                  height: 20,
                ),

                //upload pdf file

                Container(
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () async {
                      final results = await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                          type: FileType.custom,
                          allowedExtensions: ['pdf']);
                      if (results == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('No file selected.')));
                        return null;
                      }
                      final path = results.files.single.path;
                      final fileName = results.files.single.name;
                      File file = File(path!);

                      storage.UploadPdfFile(path, fileName)
                          .then((value) => Text('Done'));

                      Reference ref = FirebaseStorage.instance
                          .ref()
                          .child('basvurular/' + fileName);
                      await ref.putFile(File(file.path));
                      String pdfUrl = (await ref.getDownloadURL()).toString();
                      pdfFile = pdfUrl;
                      setState(() => pdfFile = pdfUrl);
                      print(pdfUrl);
                      if(pdfFile!=''){
                        setState(() =>fileController='fileSelected');                        
                      }
                    },
                    color: Color(0xFFFF5252),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "PDF Yükle",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.0,),

                //Upload PDF File

                //GonderButonu

               Container(
                  child: MaterialButton(
                    minWidth: double.infinity,                    
                    height: 60,
                    onPressed: () async {
                      if (formKey.currentState!.validate()&&fileController=='fileSelected') {
                      dynamic result = await storage.setApplyDataYGecis(
                          name,
                          ogrenciNo,
                          kimlikNo,
                          telNo,
                          email,
                          adres,
                          notOrt,
                          fakulte,
                          bolum,
                          pdfFile);
                          print('Başvuru kayit durumu'+result.toString());
                      if (result == false) {
                        print('Onay basarisiz');                       
                      }
                      if(result== null&&fileController=='fileSelected'){
                          setState(() =>textMessage='BAŞVURU İŞLEMİ BAŞARILI!');                          
                          }
                    }
                    else if(fileController!='fileSelected'){
                      setState(() =>textMessage='LÜTFEN DOSYA YÜKLEYİNİZ!');
                    }
                    else{
                      setState(() =>textMessage='BAŞVURU İŞLEMİ BAŞARISIZ TEKRAR DENEYİNİZ!'); 
                    }
                      
                    },
                    color: Colors.blue[300],
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Onayla",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                //Gonder Butonu

                SizedBox(height: 12.0,),
                Text(textMessage, style: TextStyle(color: Colors.red,fontSize: 16.0),
                ),                
                SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
