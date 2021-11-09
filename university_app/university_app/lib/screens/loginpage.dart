import 'package:flutter/material.dart';
import 'package:university_app/services/auth.dart';
import 'package:university_app/shared/constants.dart';
import 'package:university_app/pages/main_screen.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final AuthService _auth=AuthService();
  final _formKey =GlobalKey<FormState>();

  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  String email='';
  String password='';
  String error='';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Container(
         height: MediaQuery.of(context).size.height,        
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("Giriş Yap",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Text("Hesabınıza giriş yapın",
                    style: TextStyle(
                      fontSize: 15,
                    color:Colors.grey[700]),)
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Form(
                    key: _formKey,
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
                      ],
                    ),
                  ),
                ),
                  Padding(padding:
                  EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
                      decoration:
                        BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),

                          ),
                          


                        ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () async{
                          if(_formKey.currentState!.validate()){
                          dynamic result = await _auth.signIn(email, password);  
                          print('SORUN:'+result.toString()); 
                            if(result.toString()=="Instance of 'MyUser'"){
                             Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreen()),);                          
                          }                                         
                          if(result== false){
                          setState(() =>error='lütfen geçerli bir e-posta girin');                          
                          }                                                                           
                        }
                                            
                        },
                        color: Color(0xff0095FF),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),

                        ),
                        child: Text(
                          "Giriş Yap", style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,

                        ),
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
                    Text("Hesabınız yok mu?"),
                    Text("Kayıt olun", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,

                    ),)
                  ],
                ),

                Container(
                  padding: EdgeInsets.only(top: 100),
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/background.png"),
                      fit: BoxFit.fitHeight
                    ),

                  ),
                )

              ],
            ))
          ],
        ),
      ),
    );
  }

}


