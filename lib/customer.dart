import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acms/services/database.dart';
import 'package:acms/dashboard.dart';
//import 'package:digipay_master1/views/wallet/wallet.dart';
import 'package:acms/widgets/profile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:digipay_master1/views/wallet/account/addaccounts/globals.dart' as global;
import 'package:acms/models/uid.dart';
import 'package:toast/toast.dart';
import 'package:acms/globals.dart';
import 'package:acms/user.dart';


class MyApp7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retailer\'s list',
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
          title: Text("Retailers"),
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
  int amount;
  String name;
  String id;
  int quantity;
  String sName= shops.data['grocery_name'];

  final _formKey = GlobalKey<FormState>();
    int balance=0;
    String h;
    int fb;
  List items = getDummyList();
  
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



  void _addBalance() async{
    if(validate()){
      //print(id);
      Firestore _firestore = Firestore.instance;
      //await DatabaseService(uid: cid).updateItemDiscount(discount,id);
      int q=quantity1+amount;
     await _firestore.collection('shops').document(cid).collection('item1').document('$itemid').updateData({
       'item_quantity': q.toString(),
       
     });

     int res=quantity-amount;
     await _firestore.collection('Retailer').document(id).collection('items').document('$it').updateData({
       'quantity':res.toString(),


     });

     await _firestore.collection('Transaction').document().setData({
       'item_name': name,
       'item_quantity': amount,
       'retailer_id': id,
       'store_id': cid,
       'store_name': sName,

     });

        dialogTrigger(context);

      }
    }
     dialogTrigger(BuildContext context){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder:(BuildContext context){
          return AlertDialog(
            title: Text('Restocked'),
            
            actions: <Widget>[
              FlatButton(
                child: Text('Back'),
                onPressed: (){
                   Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }

    @override
  Widget build(BuildContext context) {
    
    return Container(
      child: StreamBuilder(
        stream: getUsersTripsStreamSnapshots1(context),
        builder: (context, snapshot) {
          if(!snapshot.hasData) return const Text("Loading...");
          return new ListView.builder(
            
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildTripCard1(context, snapshot.data.documents[index]));
        }
      ),
    );
  }
  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter item to be restocked:"),
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
  Stream<QuerySnapshot> getUsersTripsStreamSnapshots1(BuildContext context) async* {
    //final uid = await Provider.of(context).auth.getCurrentUID();
    
    print("$it");
    yield* Firestore.instance.collectionGroup('items').where('item_name',isEqualTo:'$it').snapshots();
 //print(Firestore.instance.collection('shops').getDocuments());
    
  }

  Widget buildTripCard1(BuildContext context,DocumentSnapshot card) {
    return Container(
        
          child: Card(
            elevation: 5,
            child: Container(
              height: 80.0,
              child: Wrap(
                spacing: 1.0,
                runSpacing: 6.0,
                direction: Axis.vertical,
                children: <Widget>[
                  //Text("hry")
                  Container(
                    height: 60.0,
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
                                child: const Text('Go',
                                    style: TextStyle(color: Colors.white)),
                                    padding: const EdgeInsets.all(2.0),
                                onPressed: () {
                                  createAlertDialog(context).then((onValue){
                                    SnackBar mySnackbar =SnackBar(content:Text("How much?: $onValue%") );
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
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                            child: Container(
                              width: 260,
                              child: Text(
                                "Retiler name"+card['retailer_name'],
                                style: TextStyle(
                                    fontSize: 15,
                                    //:FontStyle fontStyle(fontSize: 30.0)
                                    color: Color.fromARGB(255, 48, 48, 54)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    
                  ),
                  Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  new RaisedButton(
                                  child: new Text("Restock",
                                  style:TextStyle(
                                    fontSize:18,
                                    color:Colors.black54,
                                  )),
                                  onPressed: (){
                                    quantity=int.parse(card['quantity']);
                                    id=card['retailer_id'];

                                    name=card['item_name'];

                                    showDialog(
                                      context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
            content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: new InputDecoration(labelText: "Enter quantity for the item"),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              onSaved: (val)=>amount=int.parse(val),
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
                }
                
                );
                  //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ManageCards()));
                                  }//performSubmit,
                  ),
                  Spacer(),
                ]),
              ),
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