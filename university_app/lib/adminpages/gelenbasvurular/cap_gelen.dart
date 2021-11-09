import 'dart:convert';
import 'dart:ffi';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;


class CapGelen extends StatefulWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  _CapGelenState createState() => _CapGelenState();
}

class _CapGelenState extends State<CapGelen> {
  

  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();
  TextEditingController t1 = TextEditingController();

  get primaryColor => null;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'ÇAP GELEN BAŞVURULAR ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
      ),
      body: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future getPosts() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("capbasvurular").get();
    return qn.docs;
  }

  navigateToDetail(DocumentSnapshot<Map<String, dynamic>> post) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(post: post),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<dynamic>(
        future: getPosts(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(snapshot.data[index].data()['name']),
                    onTap: () => navigateToDetail(snapshot.data[index]),
                  );
                });
          }
        },
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  //const DetailPage({Key? key}) : super(key: key);
  final DocumentSnapshot<Map<String, dynamic>> post;
  const DetailPage({required this.post});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.data()!["name"]),
      ),
      body: Container(
        child: Card(
          child: ListTile(
            title: Text(widget.post.data()!["name"]),

            //subtitle:Text(widget.post.data()!["icerik"] ),
            subtitle: Column(
              children: [
                Text('Ad soyad:'+widget.post.data()!["name"]),
                Text('Öğrenci no:'+widget.post.data()!["ogrenciNo"]),
                Text('Kimlik no:'+widget.post.data()!["kimlikNo"]),
                Text('Email:'+widget.post.data()!["email"]),
                Text('Adres:'+widget.post.data()!["adres"]),
                Text('Fakülte:'+widget.post.data()!["fakulte"]),
                Text('Bölüm:'+widget.post.data()!["bolum"]),
                Text('Basvurulan bölüm:'+widget.post.data()!["basvurulanBolum"]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
