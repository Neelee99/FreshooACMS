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


/*class ManageCards extends StatelessWidget {

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
    yield* Firestore.instance.collection('users').document(uid).collection('cards').snapshots();
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot card) {
    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(card['card_name'], style: new TextStyle(fontSize: 20.0),),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(card['card_exp'], style: new TextStyle(fontSize: 20.0),),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(card['card_no'], style: new TextStyle(fontSize: 20.0),),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  new RaisedButton(
                                  child: new Text("Add Money to Wallet",
                                  style:TextStyle(
                                    fontSize:18,
                                    color:Colors.black54,
                                  )),
                                  onPressed: (){}//performSubmit,
                  ),
                  Spacer(),
                ]),
              ),

              /*Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
                child: Row(children: <Widget>[
                  Text(
                      "${DateFormat('dd/MM/yyyy').format(trip['startDate'].toDate()).toString()} - ${DateFormat('dd/MM/yyyy').format(trip['endDate'].toDate()).toString()}"),
                  Spacer(),
                ]),
              ),*/
              /*Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    //Text("\$${(trip['budget'] == null)? "n/a" : trip['budget'].toStringAsFixed(2)}", style: new TextStyle(fontSize: 35.0),),
                    Spacer(),
                    Icon(Icons.directions_car),
                  ],
                ),
              )*/
            ],
          ),
        ),
         
    ));
  }
}*/
final scaffoldKey = new GlobalKey<ScaffoldState>();

class ManageCards extends StatelessWidget {
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

  
  void showToast(String msg,context, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
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
    yield* Firestore.instance.collection('items').snapshots();
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot card) {
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
                  Text("Shop Name: "+card['shop_name'], style: new TextStyle(fontSize: 20.0),),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text("Shop Expiry: "+card['shop_phone'], style: new TextStyle(fontSize: 20.0),),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text("Shop email: "+card['shopkeeper_email'], style: new TextStyle(fontSize: 20.0),),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  new RaisedButton(
                                  child: new Text("Add Money to Wallet",
                                  style:TextStyle(
                                    fontSize:18,
                                    color:Colors.black54,
                                  )),
                                  onPressed: (){
                                      

                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ManageCards1()));
                                  }//performSubmit,
                  ),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  new RaisedButton(
                                  child: new Text("Add Money",
                                  style:TextStyle(
                                    fontSize:18,
                                    color:Colors.black54,
                                  )),
                                  onPressed: (){
                                      
                                      sid=card['shop_id'];
                                      

                  
                                  }//performSubmit,
                  ),
                  Spacer(),
                ]),
              ),
              

              /*Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
                child: Row(children: <Widget>[
                  Text(
                      "${DateFormat('dd/MM/yyyy').format(trip['startDate'].toDate()).toString()} - ${DateFormat('dd/MM/yyyy').format(trip['endDate'].toDate()).toString()}"),
                  Spacer(),
                ]),
              ),*/
              /*Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    //Text("\$${(trip['budget'] == null)? "n/a" : trip['budget'].toStringAsFixed(2)}", style: new TextStyle(fontSize: 35.0),),
                    Spacer(),
                    Icon(Icons.directions_car),
                  ],
                ),
              )*/
            ],
          ),
        ),
         
    ))
    );
  }

}

                /*context: context,
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
                              decoration: new InputDecoration(labelText: "Receiver's email id"),
                              onSaved: (val)=>h=(val),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: new InputDecoration(labelText: "Amount to be sent"),
                              onSaved: (val)=>bal=int.parse(val),
                            ),
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              child: Text("ADD CASH"),
                              onPressed:(
                                
                                 _addBalance),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });

                                  }//performSubmit,
                  ),
                  Spacer(),
                ]),
              ),

              /*Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
                child: Row(children: <Widget>[
                  Text(
                      "${DateFormat('dd/MM/yyyy').format(trip['startDate'].toDate()).toString()} - ${DateFormat('dd/MM/yyyy').format(trip['endDate'].toDate()).toString()}"),
                  Spacer(),
                ]),
              ),*/
              /*Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    //Text("\$${(trip['budget'] == null)? "n/a" : trip['budget'].toStringAsFixed(2)}", style: new TextStyle(fontSize: 35.0),),
                    Spacer(),
                    Icon(Icons.directions_car),
                  ],
                ),
              )*/
            ],
          ),
        ),
         
    ));
  }
}
*/