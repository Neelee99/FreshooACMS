import 'package:acms/globals.dart';
import 'package:flutter/material.dart';
import 'package:acms/widgets/profile_widget.dart';
import 'package:acms/retailer.dart';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/rendering.dart';

class LandingPage extends StatefulWidget{
  @override
  State createState()=>LandingPageState();
}

class LandingPageState extends State<LandingPage>{
 
  @override
  Widget build(BuildContext context){
  
    return Scaffold(
      body:Stack(
        fit:StackFit.expand,
        
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(image:new DecorationImage(image: AssetImage("images/photo.jpeg"))),)
        ],)
    );
  }
 
}