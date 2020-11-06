import 'package:acms/models/uid.dart';
import 'package:acms/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:string_validator/string_validator.dart' as v;
import 'package:acms/profile/datetimepick.dart';
import 'package:acms/services/database.dart';
import 'package:acms/widgets/profile_widget.dart';

final scaffoldKey = new GlobalKey<ScaffoldState>();
final formKey = new GlobalKey<FormState>();
final TextEditingController _pass = TextEditingController();
final TextEditingController _confirmPass = TextEditingController();

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      home: Scaffold(
        body: Center(
          child: ProfileForm1(),
        ),
      ),
    );
  }
}

// Create a Form widget.
class ProfileForm1 extends StatefulWidget {
  @override
  ProfileFormState createState() {
    return ProfileFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class ProfileFormState extends State<ProfileForm1> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  String _phno;
  String _name;
  //String _password;
  //String _conpassword;
  String _address;
  String _emailid;
  String _aadharno;
  int _wallet=0;

   bool validate() {
    final form = formKey.currentState; //all the text fields will be set to values
    form.save(); // to save the form
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void performSubmit() async {
    //getData();

    if (validate()) {
      try{
        final uid = await Provider.of(context).auth.getCurrentUID();
        await DatabaseService(uid: uid).updateUserData1(_name, _phno, _emailid, _aadharno, _address,_wallet);
        //await DatabaseService(uid: uid).updateWalletData('0');
        current_user_uid=uid;
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Dashboard()));
      }
      catch(e)
    {
      print(e);
      scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Processing Data')));
    }

    }

  

  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd");
    final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
    DateTime date;
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          title: new Text("Profile"),
        ),
        body:  SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(),
                    child: new Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: new Form(
                            key: _formKey,
                            child: new Form(
                              key: formKey,
                              child: new Column(children: <Widget>[
                                new TextFormField(
                                  decoration: new InputDecoration(
                                      labelText: "Enter phone number"),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Please enter some text';
                                    } else if ((val.length != 10) ||
                                        !(v.isNumeric(val))) {
                                      return 'Enter a valid phone number';
                                    }
                                    return null;
                                  },
                                  onSaved: (val) => _phno = val,
                                ),
                                new TextFormField(
                                  decoration: new InputDecoration(
                                      labelText: "Enter User Name"),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Please enter some text';
                                    } else if ((v.isNumeric(val))) {
                                      return 'Name is not valid';
                                    }
                                    return null;
                                  },
                                  onSaved: (val) => _name = val,
                                ),
                                new Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                ),
                                Text('Date Of Birth (${format.pattern})'),
                                DateTimeField(
                                  format: format,
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100));
                                  },
                                ),
                                new TextFormField(
                                  decoration: new InputDecoration(
                                      labelText: "Enter email-id"),
                                  validator: (val) {
                                    if (!(v.isEmail(val))) {
                                      return 'Enter a valid email-id';
                                    } else
                                      return null;
                                  },
                                  onSaved: (val) => _emailid = val,
                                ),
                                new TextFormField(
                                  decoration: new InputDecoration(
                                      labelText: "Enter aadhar number"),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Please enter some text';
                                    } else if ((val.length != 12) ||
                                        !(v.isNumeric(val))) {
                                      return 'Enter a valid aadhar number';
                                    }
                                    return null;
                                  },
                                  onSaved: (val) => _aadharno = val,
                                ),
                                new TextFormField(
                                  decoration: new InputDecoration(
                                      labelText: "Enter address"),
                                  onSaved: (val) => _address = val,
                                ),
                                /*new TextFormField(
                                    controller: _pass,
                                    decoration: new InputDecoration(
                                        labelText: "Enter password"),
                                    onSaved: (val) => _password = val,
                                    obscureText: true),
                                new TextFormField(
                                  controller: _confirmPass,
                                  decoration: new InputDecoration(
                                      labelText: "Confirm password"),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Password can\'t be empty';
                                    } else if (val != _pass.text) {
                                      return 'Password is not matching';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (val) => _conpassword = val,
                                  obscureText: true,
                                ),*/
                                new Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                ),
                                new RaisedButton(
                                  child: new Text("Submit"),
                                  onPressed: performSubmit,
                                ),
                              ]),
                            ))))));
  }
}