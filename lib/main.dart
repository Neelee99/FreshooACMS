//Connecting flutter and firebase steps
//1) create a new app on firebase in a project. To get the android package name- in editor, android->src->main->AndroidManifest.xml here get the package name and paste it in console
//2) download the google services.json file and place it in the folder app under android .
//3) To add the firebase sdk add dependencies. a)in the build.gradle under android folder open it and paste the classpath in the dependencies class. Net ninja video says 4.0.1 as version.. latest version is 4.3.3 (classpath 'com.google.gms:google-services:4.3.3')
//4) go to app folder->build.gradle and at the bottom of the file paste apply plugin: 'com.google.gms.google-services' also change min sdk version to 21. to add analytics features add the line implementation 'com.google.firebase:firebase-analytics:17.2.0' in the dependencies class
//5) to add firebase_auth package search firebase_auth click on pub.dev site-> installing-> copy the line (firebase_auth: ^0.15.4) and put it under dependencies of the pubspec.yaml file do the same with the line (cloud_firestore: ^0.13.0+1)


import 'package:acms/inventory.dart';
import 'package:acms/models/uid.dart';
//import 'package:acms/views/shopping_cart/cartpage.dart';
import 'package:flutter/material.dart';
//import 'home_widget.dart';
import 'dashboard.dart';
import 'package:acms/first.dart';
import 'package:acms/sign_up_view.dart';
import 'package:acms/widgets/profile_widget.dart';
import 'package:acms/services/auth_service.dart';
import 'package:acms/shoppingdemo.dart';
import 'package:acms/shop.dart';
import 'package:acms/globals.dart';
import 'package:acms/retailer.dart';
import 'package:acms/test.dart';
import 'package:acms/listShops.dart';
import 'cart.dart';                                       //ADD these
import 'history.dart'; 
import 'package:acms/solution.dart'  ;    



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        title: "Grocery App",
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/signUp': (BuildContext context) => SignUpView(authFormType: AuthFormType.signUp),
          '/signIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.signIn),
          '/home': (BuildContext context) => HomeController(),
          //'/cart': (BuildContext context) => CartPage()
             
        },
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    //setUID(context);
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          

           if(signedIn) {
             
             
             //setUID(context);
             if(f==1){
             return MyApp4();
             }
             else if(f==0){
               return MyApp11();
             }
             else if(f==3){
               return MyApp5();
             }
             else{
               return FirstView();
             }
           }
           else{
             return FirstView();
           }

        }
        return CircularProgressIndicator();
      },
    );
  }
/*void setUID(BuildContext context) async {
  final uid = await Provider
      .of(context)
      .auth
      .getCurrentUID();
  cid = uid;

}*/

}
