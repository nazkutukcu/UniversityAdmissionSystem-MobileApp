import 'package:flutter/material.dart';
import 'myheaderdrawer.dart';
import 'package:university_app/adminpages/gelenbasvurular/cap_gelen.dart';
import 'package:university_app/adminpages/gelenbasvurular/dgs_gelen.dart';
import 'package:university_app/adminpages/gelenbasvurular/intibak_gelen.dart';
import 'package:university_app/adminpages/gelenbasvurular/yazokulu_gelen.dart';
import 'package:university_app/adminpages/gelenbasvurular/ygecis_gelen.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({ Key? key }) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}
//Source code:https://www.youtube.com/watch?v=ufer4QTFTO8&list=LL&index=2 

class _AdminHomePageState extends State<AdminHomePage> {
  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      // container = DashboardPage();
    } else if (currentPage == DrawerSections.contacts) {
      container = CapGelen();
    } else if (currentPage == DrawerSections.events) {
      container = DgsGelen();
    } else if (currentPage == DrawerSections.notes) {
      container = IntibakGelen();
    } else if (currentPage == DrawerSections.settings) {
      container = YazOkuluGelen();
    } else if (currentPage == DrawerSections.notifications) {
      container = YGecisGelen();
    } else if (currentPage == DrawerSections.privacy_policy) {
      // container = PrivacyPolicyPage();
    } else if (currentPage == DrawerSections.send_feedback) {
      // container = SendFeedbackPage();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text("ADMİN BİLGİ SİSTEMİ"),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [   
                MyHeaderDrawer(),             
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "GELEN BASVURULAR", Icons.arrow_forward_rounded,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Çap Programı", Icons.arrow_right,
              currentPage == DrawerSections.contacts ? true : false),
          menuItem(3, "DGS Başvuruları", Icons.arrow_right,
              currentPage == DrawerSections.events ? true : false),
          menuItem(4, "Ders Intibak Başvuruları", Icons.arrow_right,
              currentPage == DrawerSections.notes ? true : false),          
          menuItem(5, "Yaz Okulu Başvuruları", Icons.arrow_right,
              currentPage == DrawerSections.settings ? true : false),
          menuItem(6, "Yatay Geçiş Başvuruları", Icons.arrow_right,
              currentPage == DrawerSections.notifications ? true : false),
          Divider(),
          menuItem(7, "KABUL EDİLEN BAŞVURULAR", Icons.arrow_forward_rounded,
              currentPage == DrawerSections.privacy_policy ? true : false),
          menuItem(8, "REDDEDİLEN BAŞVURULAR", Icons.arrow_forward_rounded,
              currentPage == DrawerSections.send_feedback ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.contacts;
            } else if (id == 3) {
              currentPage = DrawerSections.events;
            } else if (id == 4) {
              currentPage = DrawerSections.notes;
            } else if (id == 5) {
              currentPage = DrawerSections.settings;
            } else if (id == 6) {
              currentPage = DrawerSections.notifications;
            } else if (id == 7) {
              currentPage = DrawerSections.privacy_policy;
            } else if (id == 8) {
              currentPage = DrawerSections.send_feedback;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  dashboard,
  contacts,
  events,
  notes,
  settings,
  notifications,
  privacy_policy,
  send_feedback,
}