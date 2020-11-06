import 'package:acms/restock1.dart';
import 'package:acms/shop.dart';
import 'package:flutter/material.dart';
import 'package:acms/services/auth_service.dart';
import 'package:acms/widgets/profile_widget.dart';
import 'package:acms/first.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acms/globals.dart';
import 'package:acms/user.dart';
import 'package:acms/crud.dart';



class MyApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery Home page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ALL ITEMS PRESENT"),
           actions: <Widget>[
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: () async {
              
                
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MyApp2()));

              
            },
          )
          
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
  crudMethods crudObj=new crudMethods();
  final _formKey = GlobalKey<FormState>();
  bool validate() {
    final form = _formKey.currentState; //all the text fields will be set to values
    form.save(); // to save the form
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
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
    yield* Firestore.instance.collection('Item').snapshots();
  }
  List items = getDummyList();
  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();


  }
  //================
  Future<String> createAlertDialog1(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter Restock quantity for the item:"),
            content: TextField(
              controller: customController,
              ),
            actions: <Widget>[
              MaterialButton(
                elevation:5.0,
                child:Text("Submit"),
                onPressed: (){
                  Navigator.of(context).pop(customController.text.toString());
                },
              )
            ],
          );
        });
  }
  //================
 
  
  Widget buildTripCard(BuildContext context,DocumentSnapshot card) {
    crudObj.getShopName(cid).then((results) {
      if (results == null) {
        print('no data');
      }
      setState(() {
        shops = results;
      });
    });
    print(shops.data['grocery_name']);
    String s=card.documentID;
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
                      // image: DecorationImage(
                      //  fit: BoxFit.cover,
                      //   image: NetworkImage("https://is2-ssl.mzstatic.com/image/thumb/Video2/v4/e1/69/8b/e1698bc0-c23d-2424-40b7-527864c94a8e/pr_source.lsr/268x0w.png")
                      // )
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
                                child: const Text('Restock',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  it=s;
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MyApp50()));
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
                          Text(
                            "Item:$s",
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 4, 0, 2),
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.teal),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              /*child: Text(
                                "Quantity Left : 65 KG",
                                //Text("Discount : $onValue")
                                textAlign: TextAlign.center,
                              ),*/
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                            child: Container(
                              width: 260,
                              
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
      return "Item ${i + 1}";
    });
    return list;
  }
}
