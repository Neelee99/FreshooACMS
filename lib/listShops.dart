import 'package:flutter/material.dart';
import 'package:acms/services/auth_service.dart';
import 'package:acms/widgets/profile_widget.dart';
import 'package:acms/first.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acms/globals.dart';
import 'package:acms/user.dart';
import 'package:acms/crud.dart';
import 'package:acms/shopItems.dart';
import 'cart.dart';
import 'history.dart';

class MyApp5 extends StatelessWidget {
  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery Home page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
  routes: {
     
    '/cart':(context)=>cart(),                             //ADD these in routes
    '/history':(context)=>history()
  },
      home: MyHomePage(),
    );
  }
}
Widget build(BuildContext context) {
    //setR(context);
    return MaterialApp(
  initialRoute: '/',
  routes: {
     '/cart':(context)=>cart(),                             //ADD these in routes
    '/history':(context)=>history()   
  },
);
  }
class MyHomePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    //const PrimaryColor = const Color(green);
    return Scaffold(
        appBar: AppBar(
          title: Text("List of shops"),
          //backgroundColor: PrimaryColor,
          flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
              Colors.green,
              Colors.blue
            ])          
         ), 


     ),  
     actions: <Widget>[
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: () async {
              try {
                AuthService auth = Provider.of(context).auth;
                await auth.signOut();
                print("Signed Out!");
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => FirstView()));

              } catch (e) {
                print (e);
              }
            },
          ),
         FlatButton(
                child: Text('History'),
                color: Colors.lightBlueAccent[500],
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, '/history',arguments: cid);
                },
              ),
          
        ],
        
        
          
        ),
        
        body: Center(child: SwipeList()),
    );  
  }
}

class SwipeList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListItemWidget();
  }
}


class ListItemWidget extends State<SwipeList> {
  List items = getDummyList();
  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();


  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: getUsersTripsStreamSnapshots(context),
        builder: (context, snapshot) {
          if(!snapshot.hasData) return const Text("Loading..");
          return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildTripCard(context, snapshot.data.documents[index]));
        }
      ),
    );
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('shops').snapshots();
  }
  //================
  Future<String> createAlertDialog1(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Taking you to the Virtual Shopping Experience"),
            //content: TextField(
            //  controller: customController,
            // ),
            actions: <Widget>[
              MaterialButton(
                elevation:5.0,
                child:Text("please wait..."),
                onPressed: (){
                  
                  Navigator.of(context).pop(customController.text.toString());
                },
              )
            ],
          );
        });
  }
  //================
 
  @override
  Widget buildTripCard(BuildContext context, DocumentSnapshot card) {
    return Container(
        
          child: Card(
            elevation: 5,
            child: Container(
              height: 70.0,
              child: Wrap(
                spacing: 1.0,
                runSpacing: 6.0,
                direction: Axis.vertical,
                children: <Widget>[
                  //Text("hry")
                  Container(
                    height: 100.0,
                    width: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          topLeft: Radius.circular(5)),
                      image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://www.dumpsters.com/images/blog/grocery-store-waste_1540998058/grocery-store-waste-1200x600.jpg")
                       )
                    ),
                  ),
                  //================================
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ButtonTheme(
                          child: ButtonBar(
                            children: <Widget>[
                             
                              RaisedButton(
                                color: Colors.green,
                                child: const Text('GO',
                                
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  csname=card['grocery_name'];
                                  csid=card['grocery_id'];
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MyApp6()));
                                  
                                }),
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  
                  //==================================
                  Container(
                    height: 85,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 2, 0, 9),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                         
                         
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                            child: Container(
                              width: 260,
                              child: Text(
                                card['grocery_name'],
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 48, 48, 54)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        
      
    );
  }

  static List getDummyList() {
    List list = List.generate(10, (i) {
      return " ";
    });
    return list;
  }
}
