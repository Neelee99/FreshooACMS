import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:acms/widgets/custom_dialog.dart';

class FirstView extends StatelessWidget {
  final primaryColor = const Color(0xFF81C784);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      
      body: Container(
        width: _width,
        height: _height,
        color: primaryColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                /*Container(
                    height: 100.0,
                    width: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          topLeft: Radius.circular(5)),
                      image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://www.google.com/url?sa=i&url=http%3A%2F%2Fwww.atlaswebdevelopmentpro.com%2F&psig=AOvVaw1RpKmyLNYtcK_fBH_7r0ti&ust=1588512447787000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCMCAopWklekCFQAAAAAdAAAAABAa")
                      )
                    ),
                  ),
                  */
                SizedBox(height: _height * 0.1),
        
                Text(
                  "Freshoo",
                  
                  style: TextStyle(
                  fontSize: 40,
                  //fontStyle: FontStyle.italic,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2
                    ..color = Colors.green[700],
                    fontFamily: 'Raleway'
                ),
                
              ),
                SizedBox(height: _height * 0.01),
                AutoSizeText(
                  "The Neighbourhood Store",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 24,
                    color: Colors.green[900],
                  ),
                ),
                SizedBox(height: _height * 0.15),
                //==================
                
                //child: Card(
                //--------------------
                 Container(
                   
                  margin: const EdgeInsets.all(1.0),
                  padding: const EdgeInsets.all(1.0),
                  
                  //padding: EdgeInsets.fromLTRB(1,1,1,0),
                  height: 260,
                  width: double.maxFinite,
                  child: Card(
                    color: Colors.lime[50],
                    elevation: 35,
                    margin: EdgeInsets.only(top: 1),
                    shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(60.0)),
                    child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                  
                //--------------------
                SizedBox(height: _height * 0.06),
                RaisedButton(
                  color: Color(0xFF81C784),
                  
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                      
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
                    
                    child: Text(
                      "Get Started",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.green[900],
                        
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomDialog(
                        title: "Join our Family",
                        description:
                        "Our Grocery store will help you a lot!!",
                        primaryButtonText: "Create My Account",
                        primaryButtonRoute: "/signUp",
                        secondaryButtonText: "",
                        secondaryButtonRoute: "/home",
                      ),
                    );
                  },
                ),
                SizedBox(height: _height * 0.01),
                FlatButton(
                  child: Text(
                    "Sign In",
                    style: TextStyle(color: Color(0xFF81C784), fontSize: 25),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/signIn');
                  },
                )
                //==================
             ]))))],
            ),
          ),
        ),
      ),
    );
  }
}
