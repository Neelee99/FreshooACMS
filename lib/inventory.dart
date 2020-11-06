import 'package:flutter/material.dart';
import 'package:acms/services/auth_service.dart';
import 'package:acms/widgets/profile_widget.dart';
import 'package:acms/first.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final scaffoldKey = new GlobalKey<ScaffoldState>();
class MyApp1 extends StatelessWidget {
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
          title: Text("Inventory"),
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
          if(!snapshot.hasData) return const Text("Loading...");
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
    yield* Firestore.instance.collectionGroup('item').where('item_name',isEqualTo:'soap').snapshots();
    
  }


  List items = getDummyList();
  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();


    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter discount for the item:"),
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
  //================
  Future<String> createAlertDialog2(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter Price for the item:"),
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
    print(card);
    String s=card['retailer_name'];
    return Container(
        
      
        
         
         
          child: Card(
            elevation: 5,
            child: Container(
              height: 150.0,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ButtonTheme(
                          child: ButtonBar(
                            children: <Widget>[
                              RaisedButton(
                                child: const Text('Discount',
                                    style: TextStyle(color: Colors.white)),
                                    padding: const EdgeInsets.all(2.0),
                                onPressed: () {
                                  createAlertDialog(context).then((onValue){
                                    SnackBar mySnackbar =SnackBar(content:Text("Discount : $onValue%") );
                                    Scaffold.of(context).showSnackBar(mySnackbar);
                                  });
                                },
                              ),
                              RaisedButton(
                                child: const Text('Restock',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  createAlertDialog1(context).then((onValue){
                                    SnackBar mySnackbar =SnackBar(content:Text("Restock Amount : $onValue units") );
                                    Scaffold.of(context).showSnackBar(mySnackbar);
                                  });
                                }),
                              RaisedButton(
                                child: const Text('Price',
                                    style: TextStyle(color: Colors.white)),
                               onPressed: () {
                                  createAlertDialog2(context).then((onValue){
                                    SnackBar mySnackbar =SnackBar(content:Text("Price : Rs.$onValue") );
                                    Scaffold.of(context).showSnackBar(mySnackbar);
                                  });
                                },
                              ),
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
                            padding: EdgeInsets.fromLTRB(0, 4, 0, 2),
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.teal),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Text(
                                "Quantity Left :$s",
                                //Text("Discount : $onValue")
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                            child: Container(
                              width: 260,
                              child: Text(
                                "Price : 35/KG",
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
      return "Item ${i + 1}";
    });
    return list;
  }
}