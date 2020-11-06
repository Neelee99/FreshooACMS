/*import 'package:flutter/material.dart';
import 'package:acms/services/auth_service.dart';
import 'package:acms/widgets/profile_widget.dart';
import 'package:acms/first.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acms/globals.dart';
import 'package:acms/user.dart';
import 'package:acms/crud.dart';
import 'shop.dart';



class MyApp10 extends StatelessWidget {
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

  
  void _addBalance() async{
    if(validate()){
      //print(id);
     // Firestore _firestore = Firestore.instance;
      //await DatabaseService(uid: cid).updateItemDiscount(discount,id);
      //print(id);
      Firestore _firestore = Firestore.instance;
      //await DatabaseService(uid: cid).updateItemDiscount(discount,id);
     await _firestore.collection('shops').document(cid).collection('item1').document(ids).updateData({
      'item_price': price.toString(),
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
            title: Text('payment done'),
            content: Text('succesfully'),
            actions: <Widget>[
              FlatButton(
                child: Text('alright'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp2()));
                },
              )
            ],
          );
        }
    );
  }
  
  
  //================
  
  //================
 
  
  Future<String> buildTripCard(BuildContext context) {
           return  showDialog(
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    buildTripCard(context);
    //return null;
  }

}*/