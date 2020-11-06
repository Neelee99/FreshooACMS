import 'package:acms/customer.dart';
import 'package:flutter/material.dart';
import 'package:acms/services/auth_service.dart';
import 'package:acms/widgets/profile_widget.dart';
import 'package:acms/first.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acms/inventory2.dart';
import 'package:acms/globals.dart';
import 'package:acms/services/database.dart';
import 'package:acms/user2.dart';
import 'package:acms/crud.dart';
import 'package:acms/solution.dart';
import 'package:acms/restock.dart';




final scaffoldKey = new GlobalKey<ScaffoldState>();
class MyApp2 extends StatelessWidget {
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
            icon: Icon(Icons.arrow_back),
            onPressed: ()  {
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MyApp11()));
            },
          )
          
        ],

        ),
        floatingActionButtonLocation: 
      FloatingActionButtonLocation.endDocked,
    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.add), onPressed: () {},),
    bottomNavigationBar: BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //IconButton(icon: Icon(Icons.menu), onPressed: () {},),
          IconButton(icon: Icon(Icons.search), onPressed: () {

            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MyApp3()));
          },),
        ],
      ),
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
  Future<bool>dialogTrigger(BuildContext context)async{
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder:(BuildContext context){
        return AlertDialog(
          title: Text('job done'),
          content: Text('added'),
          actions: <Widget>[
            FlatButton(
              child: Text('alright'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }
  crudMethods crudObj=new crudMethods();
  DatabaseService k= new  DatabaseService();

  Firestore _firestore = Firestore.instance;
  int price;

  int discount;
  final _formKey = GlobalKey<FormState>();
  String id;
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
  bool validate1() {
    final form1 = _formKey.currentState; //all the text fields will be set to values
    form1.save(); // to save the form
    if (form1.validate()) {
      form1.save();
      return true;
    } else {
      return false;
    }
  }

  void _addBalance() async{
    if(validate1()){
      print(id);
      //Firestore _firestore = Firestore.instance;
      //await DatabaseService(uid: cid).updateItemDiscount(discount,id);
     await _firestore.collection('shops').document(cid).collection('item1').document(id).updateData({
       'item_discount': discount,
     });
      

      
      
     dialogTrigger(context); 
        
      
      
      //Navigator.pushReplacement(context, newRoute)
      
    }


  }

  void _addBalance1() async{
  if(validate()){
  k.updateItemPrice(price,id).
                          then((result) {
                            dialogTrigger(context);
                          }).
                          catchError((e) {
                            print(e);
                          });


  }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: getUsersTripsStreamSnapshots(context),
        builder: (context, snapshot) {
          if(!snapshot.hasData) return const Text("Your Inventory is empty");
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
    cid=uid;
    yield* Firestore.instance.collection('shops').document(uid).collection('item1').snapshots();
  }
  List items = getDummyList();
  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: new InputDecoration(labelText: "Enter discount for the item"),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              onSaved: (val)=>discount=int.parse(val),
                            ),
                          ),
                          
                          Padding(
                            
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              child: Text("Submit"),
                              onPressed:(
                                 
                                
                                 _addBalance
                                 
                                 ),
                            ),
                          )
                        ],
                      ),
                    ),
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
    

    crudObj.getShopName(cid).then((results) {
      if (results == null) {
        print('no data');
      }
      setState(() {
        shops = results;
      });
    });
    print(shops.data['grocery_name']);

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
                                  id=card.documentID;
                                  
                                  showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: new InputDecoration(labelText: "Enter discount for the item"),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              onSaved: (val)=>discount=int.parse(val),
                            ),
                          ),
                          
                          Padding(
                            
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              child: Text("Submit"),
                              onPressed:(
                                 
                                
                                 _addBalance
                                 
                                 ),
                            ),
                          )
                        ],
                      ),
                    ),
          );
        });
                                },
                              ),
                              RaisedButton(
                                child: const Text('Restock',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  it=card['item_name'];
                                  itemid=card.documentID;
                                  quantity1=int.parse(card['item_quantity']);
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MyApp9()));
                                }),
                              RaisedButton(
                                child: const Text('Price',
                                    style: TextStyle(color: Colors.white)),
                               onPressed: () {
                                  id=card.documentID;
                                  
                                  showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: new InputDecoration(labelText: "Enter price of the item"),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              onSaved: (val)=>price=int.parse(val),
                            ),
                          ),
                          
                          Padding(
                            
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              child: Text("Submit"),
                              onPressed:(
                                 
                                
                                 _addBalance1
                                 
                                 ),
                            ),
                          )
                        ],
                      ),
                    ),
          );
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
                            padding: EdgeInsets.fromLTRB(0, 1, 0, 2),
                            child: Container(
                              width: 260,
                              child: Text(
                                "Item :"+ card['item_name'],
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 48, 48, 54)),
                              ),
                            ),
                          ),
                          
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 1, 0, 2),
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.teal),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Text(
                                "Quantity Left : "+card['item_quantity'],
                                //Text("Discount : $onValue")
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 1, 0, 2),
                            child: Container(
                              width: 260,
                              child: Text(
                                "Price : \₹"+card['item_price'],
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