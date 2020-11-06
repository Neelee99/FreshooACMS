import 'package:acms/listShops.dart';
import 'package:flutter/material.dart';
import 'package:acms/services/auth_service.dart';
import 'package:acms/widgets/profile_widget.dart';
import 'package:acms/first.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acms/globals.dart';
import 'package:acms/user.dart';
import 'package:acms/crud.dart';
import 'history.dart';
import 'cart.dart';


class MyApp6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
      initialRoute: '/',
  routes: {
     
    '/cart':(context)=>cart(),                             //ADD these in routes
    '/history':(context)=>history()
  },
    );
  }
}

class MyHomePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Items available in $csname"),
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
            icon: Icon(Icons.arrow_back),
            onPressed: ()  {
             _delete();
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MyApp5()));
            },
          )
          
        ],  
        ),
        floatingActionButtonLocation: 
      FloatingActionButtonLocation.endDocked,
    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.add_shopping_cart), onPressed: () {
        Navigator.pushNamed(context,'/cart',arguments: [cid,csname,csid]);    
      },),
    bottomNavigationBar: BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //IconButton(icon: Icon(Icons.menu), onPressed: () {},),
          IconButton(icon: Icon(Icons.search), onPressed: () {},),
        ],
      ),
    ),
      
    
        body: Center(child: SwipeList()),
    );  
  }
  
}
void _delete() async{
    
      //print(id);
      Firestore _firestore = Firestore.instance;
      //await DatabaseService(uid: cid).updateItemDiscount(discount,id);
      //int q=quantity1+amount;
     

     //int res=quantity-amount;
     await _firestore.collection('Customer').document(cid).collection('cart').getDocuments().then((snapshot) {
  for (DocumentSnapshot doc in snapshot.documents) {
    String id=doc.documentID;
    print(id);
    Firestore.instance
        .collection('Customer').document(cid).collection('cart')
        .document('$id')
        .delete();
    
  }});

  /*Firestore.instance
        .collection('Customer').document(cid).collection('cart')
        .document('apple')
        .delete();*/

     
        

    
    }

class SwipeList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListItemWidget();
  }
}

class ListItemWidget extends State<SwipeList> {
  String iname;
  String itemUpdateid;
  int amount;
  int price;
  int d;
  List items = getDummyList();
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
      Firestore _firestore = Firestore.instance;
      //await DatabaseService(uid: cid).updateItemDiscount(discount,id);
      //int q=quantity1+amount;
     

     //int res=quantity-amount;
     await _firestore.collection('Customer').document(cid).collection('cart').document('$iname').setData({
       'item_name':iname,
       'item_quantity':amount.toString(),
       'item_price':price.toString(),
       'item_discount':d.toString(),
       'quantity_type':'kg'



     });

     
        

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
    yield* Firestore.instance.collection('shops').document(csid).collection('item1').snapshots();
  }

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
            title: Text("Enter qty for the item:"),
            content:  Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: new InputDecoration(labelText: "Enter quantity "),
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

            actions: <Widget>[
              MaterialButton(
                elevation:5.0,
                child:Text("Back"),
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
              height: 100.0,
              child: Wrap(
                spacing: 1.0,
                runSpacing: 6.0,
                direction: Axis.vertical,
                children: <Widget>[
                  //Text("hry")
                  //==================

                  //====================
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ButtonTheme(
                          child: ButtonBar(
                            children: <Widget>[
                          
                              RaisedButton(
                                child: const Text('Add',
                                    style: TextStyle(color: Colors.white)),
                               onPressed: () {
                                 itemUpdateid=card.documentID;
                                 iname=card['item_name'];
                                 price=int.parse(card['item_price']);
                                 d=card['item_discount'];

                                  createAlertDialog2(context).then((onValue){
                                    SnackBar mySnackbar =SnackBar(content:Text("Price : Rs.$onValue") );
                                    Scaffold.of(context).showSnackBar(mySnackbar);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                     

                  
                  //==================================
                  Container(
                    height: 85,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 11, 20, 9),
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
                                "Item Name : "+card['item_name'],
                                //Text("Discount : $onValue")
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                         
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 4, 0, 2),
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.teal),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Text(
                                "Quantity Present : "+card['item_quantity'],
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
                                "Price : "+card['item_price'],
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 48, 48, 54)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                            child: Container(
                              width: 260,
                              child: Text(
                                "Discount : "+"card['item_discount']"+"%",
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