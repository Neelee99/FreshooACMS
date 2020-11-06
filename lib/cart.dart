import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:acms/crud.dart';
import 'listShops.dart';

class cart extends StatefulWidget {
  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<cart> {
  crudMethods crudObj = new crudMethods();
  QuerySnapshot items;
  double total = 0;
  var a=[];
  int i=0;
  var shopName;



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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp5()));
                },
              )
            ],
          );
        }
    );
  }

  Widget buildRow(Item, addValue,n) {

    if(i<n) {
      a.add(Item.data);
      a[i]['shopName'] =shopName ;
      a[i]['name']=Item.data['item_name'];
      a[i]['quantity']=Item.data['item_quantity'];
      
      
    }
    //print(Item.data['item_price']);
    String x=Item.data['item_price'];
    var cost = double.parse(x);
    print(cost);
    
    
    var discount = double.parse(Item.data['item_discount']);
    var quantity=double.parse(Item.data['item_quantity']);
    var p = 1;
    if (Item.data['quantity_type'] == 'unit') {
      p = 0;
    }
    cost = cost - cost * discount / 100;
    cost=cost*quantity;
    if(i<n){
      a[i]['item_price']=cost.toString();
      i=i+1;
    }
    total = addValue + cost;
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(Item.data['item_name'],style: TextStyle(
                fontSize: 20
              ),),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(Item.data['item_quantity']),
                  SizedBox(width: 10),
                  if (p ==1 )
                    Text(Item.data['quantity_type']),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('COST: '),
                  Text(cost.toString()),
                  Text('Rs')
                ],
              )
            ],
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget list() {
    if (items != null) {
      return ListView.builder(
         itemCount: items.documents.length,
          itemBuilder: (BuildContext content, int index) {
           var n=items.documents.length;
           
           if(index == 0) total = 0.0;
            DocumentSnapshot item = items.documents[index];
            return buildRow(item, total,n);
          });
    }
    else {
      print('loading');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> data = ModalRoute.of(context).settings.arguments;
    print(data[0]);
    print(data[1]);
    print(data[2]);

    var custID = data[0];
    shopName = data[1];
    var shopID=data[2];
    crudObj.getCart(custID).then((results) {
      if (results == null) {
        print('no data');
      }
      setState(() {
        
        items = results;
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(shopName)),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Container(
              width: 100,
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, size: 20),
                  hintText: 'Search',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
          child: list(),
      ),
      persistentFooterButtons: <Widget>[
        ButtonBar(children: <Widget>[
          Text(total.toString())
        ],
        ),
        FloatingActionButton(
          child: Text('PAY'),
          onPressed:() {
            
            crudObj.updateShop(shopID,a).
            then((result) {
              crudObj.addHistory(custID,a).
              then((result) {
                crudObj.emptyCart(custID,a).
                then((result) {
                  dialogTrigger(context);
                }).
                catchError((e) {
                  print(e);
                });
              }).
              catchError((e) {
                print(e);
              });
            }).
            catchError((e) {
              print(e);
            });


            Navigator.pushNamed(context, '/');
          }
    ),
        
      ],
    );
  }
}