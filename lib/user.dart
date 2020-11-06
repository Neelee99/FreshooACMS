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
import 'package:acms/crud.dart';



final scaffoldKey = new GlobalKey<ScaffoldState>();

class ManageCards1 extends StatelessWidget {
  int amount;
  String name;
  String id;
  int quantity;
  String sName= shops.data['grocery_name'];
  
  crudMethods crudObj = new crudMethods();


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
     await _firestore.collection('shops').document(cid).collection('item1').document().setData({
       'item_quantity': amount.toString(),
       'item_name':name,
       'item_price':'',
       'item_discount':0
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
        

      }
    }




  
  void showToast(String msg,context, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
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

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots1(BuildContext context) async* {
    //final uid = await Provider.of(context).auth.getCurrentUID();
    

    yield* Firestore.instance.collectionGroup('items').where('item_name',isEqualTo:'$it').snapshots();
 //print(Firestore.instance.collection('shops').getDocuments());
    
  }

  Widget buildTripCard1(BuildContext context, DocumentSnapshot card) {
    
    
    print("hello");
    return new Container(

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
}

                