import 'package:flutter/material.dart';
import 'package:acms/services/auth_service.dart';
import 'package:acms/widgets/profile_widget.dart';
import 'package:acms/first.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acms/globals.dart';
import 'package:acms/user.dart';
import 'package:acms/crud.dart';
import 'shop.dart';



class MyApp9 extends StatelessWidget {
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
            icon: Icon(Icons.arrow_back),
            onPressed: ()  {
             Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MyApp2()));
            }
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
  int amount;
  String name;
  String id;
  int quantity;
  String sName= shops.data['grocery_name'];
  String retailer_name;
  int cp;
  String type;


  final _formKey = GlobalKey<FormState>();
    int balance=0;
    String h;
    int fb;
  
  
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
       'item_cp':cp.toString()
       
     });

     int res=quantity-amount;
     await _firestore.collection('Retailer').document(id).collection('items').document('$it').updateData({
       'quantity':res.toString(),


     });

     await _firestore.collection('Transaction').document().setData({
       'item_name': name,
       'item_quantity': amount.toString(),
       'retailer_id': id,
       'store_id': cid,
       'store_name': sName,
       'retailer_name':retailer_name

     });

       dialogTrigger(context); 

      }
    }
    Future<bool>dialogTrigger(BuildContext context)async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder:(BuildContext context){
          return AlertDialog(
            title: Text('Restocked'),
            //content: Text('succesfully'),
            actions: <Widget>[
              FlatButton(
                child: Text('Back'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp2()));
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
    yield* Firestore.instance.collectionGroup('items').where('item_name',isEqualTo:'$it').snapshots();

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
    
   
    String s=card.documentID;
    return Container(
        
         child:SingleChildScrollView(
        
      child: Card(
        
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text("Retailer Name: "+card['retailer_name'], style: new TextStyle(fontSize: 20.0),),
                  Spacer(),
                ]),
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
                                    retailer_name=card['retailer_name'];
                                    type=card['quantity_type'];

                                    name=card['item_name'];
                                    cp=int.parse(card['cost']);

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
                              decoration: new InputDecoration(labelText: "Enter amount for the item"),
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
        

         
    ))
        
      
    );
  }

  static List getDummyList() {
    List list = List.generate(10, (i) {
      return "Item ${i + 1}";
    });
    return list;
  }
}