import 'package:flutter/material.dart';
import 'package:university_app/shared/constants.dart';
import 'package:university_app/services/auth.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:university_app/services/storage_services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:university_app/pages/main_screen.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

final AuthService _auth=AuthService();
final _formKey =GlobalKey<FormState>();

  String email='';
  String password='';
  String error='';
  String name='';
  String surname='';
  String ogrenciNo='';
  String telNo='';
  String kimlikNo='';
  String dogumTarihi='';
  String adres='';
  String fakulte='';
  String bolum='';
  String img='';
  var imgController='';

  @override
  Widget build(BuildContext context) {
    final Storage storage=Storage();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,),


        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          //  height: MediaQuery.of(context).size.height +50,
           height: 1100,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Kayıt Olun",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,

                  ),),
                  SizedBox(height: 20,),
                  Text("Bir hesap oluşturun. ",
                    style: TextStyle(
                        fontSize: 15,
                        color:Colors.grey[700]),)


                ],
              ),
              Form(
                key: _formKey ,                
                child: Column(
                  children: <Widget>[
                  SizedBox(height: 10.0,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email') ,
                    validator: (val)=>val!.isEmpty ?'Enter an email':null,
                    onChanged: (val){
                     setState(()=>email=val);
                    },
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(hintText: 'Şifre') ,
                    validator: (val)=>val!.length<6 ?'Enter a password':null,
                    onChanged: (val){
                     setState(()=>password=val);
                    },
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Ad') ,
                    validator: (val)=>val!.isEmpty ?'Enter a name':null,
                    onChanged: (val){
                     setState(()=>name=val);
                    },
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Soyad') ,
                    validator: (val)=>val!.isEmpty ?'Enter a surname':null,
                    onChanged: (val){
                     setState(()=>surname=val);
                    },
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Öğrenci No') ,                    
                    validator: (val)=>val!.isEmpty ?'Enter your ...':null,
                    onChanged: (val){
                      setState(()=>ogrenciNo=val);
                    },
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Telefon No') ,                   
                    validator: (val)=>val!.isEmpty ?'Enter your ...':null,
                    onChanged: (val){
                      setState(()=>telNo=val);
                    },
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Kimlik No') ,                    
                    validator: (val)=>val!.isEmpty ?'Enter your ...':null,
                    onChanged: (val){
                      setState(()=>kimlikNo=val);
                    },
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Dogum Tarihi') ,                    
                    validator: (val)=>val!.isEmpty ?'Enter your ...':null,
                    onChanged: (val){
                      setState(()=>dogumTarihi=val);
                    },
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Adres') ,                    
                    validator: (val)=>val!.isEmpty ?'Enter your ...':null,
                    onChanged: (val){
                      setState(()=>adres=val);
                    },
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Fakulte') ,                    
                    validator: (val)=>val!.isEmpty ?'Enter your ...':null,
                    onChanged: (val){
                      setState(()=>fakulte=val);
                    },
                  ),
                   SizedBox(height: 10.0,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Bolum') ,                    
                    validator: (val)=>val!.isEmpty ?'Enter your ...':null,
                    onChanged: (val){
                      setState(()=>bolum=val);
                    },
                  ),
                  SizedBox(height: 10.0,),
                  Container( //Upload img
                    child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: ()async {
                    final results= await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.custom,
                  allowedExtensions: ['png','jpg']
                );
                if(results==null){
                  ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(
                    content: Text('No file selected.')
                    ));
                    return null;
                }
                final path= results.files.single.path;
                final fileName=results.files.single.name;
                File file=File(path!);

                storage
                .UploadFile(path, fileName)
                .then((value) => Text('Done'));

                Reference ref=FirebaseStorage.instance.ref().child('usersImages/'+fileName);      
                await ref.putFile(File(file.path));                             
                String imgUrl=(await ref.getDownloadURL()).toString(); 
                img=imgUrl;
                setState(()=>img=imgUrl);
                print(imgUrl);
                if(imgUrl!=''){
                        setState(() =>imgController='fileSelected');                        
                      }
                  },
                  color: Color(0xFFFF5252),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Resim Yükle", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  ),
                ),
                  ), //Upload img                 
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration:
                BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                    )
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: ()async {
                    if(_formKey.currentState!.validate()&&imgController=='fileSelected'){
                        dynamic result = await _auth.register(email, password,name,surname,ogrenciNo,telNo,kimlikNo,dogumTarihi,adres,fakulte,bolum,img).then((_) => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreen()),
                          ));                        
                        if(result== false){
                          setState(() =>error='Lütfen bilgileri eksiksiz giriniz');
                        }
                      }else if(imgController!='fileSelected'){
                        setState(() =>error='Lütfen resminizi eksiksiz giriniz');
                      }
                     
                  },
                  color: Color(0xff0095FF),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),

                  ),
                  child: Text(
                    "Kayıt Ol", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  ),
                ),
              ),

              SizedBox(height: 12.0,),
                Text(error, style: TextStyle(color: Colors.red,fontSize: 16.0),
                ),
                SizedBox(height: 12.0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Hesabınız var mı?"),
                  Text(" Giriş Yap", style:TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                  ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}