import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class Profilepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProfilepageState();
  }
}

class _ProfilepageState extends State<Profilepage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Contact newContact = new Contact();

  bool wantPCSI = false;
  bool wantMPSI = false;
  bool wantPTSI = false;
  bool wantPSI = false;
  bool wantPC = false;
  bool wantMP = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> content = [];

    if (Platform.isIOS) {
      // Hack to fix a crash
      // return CupertinoPageScaffold(child: Column(children: content,),navigationBar: CupertinoNavigationBar(leading: Text("Accueil"),),);
      content.add(CupertinoNavigationBar(
          transitionBetweenRoutes: false, middle: Text("Profil")));
    }
    return new Scaffold(
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Entre ton nom et ton prénom',
                      labelText: 'Nom Prenom',
                    ),
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) =>
                        val.isEmpty ? 'Il faut renseigner un nom prénom' : null,
                    onSaved: (val) => newContact.name = val,
                  ),
                  new Row(children: <Widget>[
                    new Expanded(
                        child: new TextFormField(
                      decoration: new InputDecoration(
                        icon: const Icon(Icons.calendar_today),
                        hintText: 'Entre ta date de naissance',
                        labelText: 'Date de naissance',
                      ),
                      controller: _controller,
                      keyboardType: TextInputType.datetime,
                      validator: (val) =>
                          isValidDob(val) ? null : 'Not a valid date',
                    )),
                    new IconButton(
                      icon: new Icon(Icons.more_horiz),
                      tooltip: 'Choose date',
                      onPressed: (() {
                        _chooseDate(context, _controller.text);
                      }),
                    )
                  ]),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.business_center),
                      hintText: 'Entre le nom et la ville de ton lycée',
                      labelText: 'Lycée',
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Il faut renseigner un lycée' : null,
                    onSaved: (val) => newContact.lycee = val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.email),
                      hintText: 'Renseigne ton adresse mail',
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => isValidEmail(value)
                        ? null
                        : 'Renseigne une adresse mail valide',
                    onSaved: (val) => newContact.email = val,
                  ),
                  new Text(
                    ' ',
                  ),
                  new Text(
                    'Choisis les classes qui t\'intéressent',
                  ),
                  new Text(' '),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // [Monday] checkbox
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("PCSI"),
                          Checkbox(
                            value: wantPCSI,
                            onChanged: (bool value) {
                              setState(() {
                                wantPCSI = value;
                              });
                            },
                          ),
                        ],
                      ),
                      // [Tuesday] checkbox
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("MPSI"),
                          Checkbox(
                            value: wantMPSI,
                            onChanged: (bool value) {
                              setState(() {
                                wantMPSI = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("PTSI"),
                          Checkbox(
                            value: wantPTSI,
                            onChanged: (bool value) {
                              setState(() {
                                wantPTSI = value;
                              });
                            },
                          ),
                        ],
                      ),
                      // [Wednesday] checkbox
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("MP"),
                          Checkbox(
                            value: wantMP,
                            onChanged: (bool value) {
                              setState(() {
                                wantMP = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("PSI"),
                          Checkbox(
                            value: wantPSI,
                            onChanged: (bool value) {
                              setState(() {
                                wantPSI = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("PC"),
                          Checkbox(
                            value: wantPC,
                            onChanged: (bool value) {
                              setState(() {
                                wantPC = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  new Container(
                      //padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        child: const Text('Sauvegarder'),
                        onPressed: _submitForm,
                      )),
                ],
              ))),
    );
  }

  final TextEditingController _controller = new TextEditingController();
  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
        ? initialDate
        : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());

    if (result == null) return;

    setState(() {
      _controller.text = new DateFormat.yMd().format(result);
    });
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save(); //This invokes each onSaved event

      print('Form save called, newContact is now up to date...');
      print('Email: ${newContact.name}');
      print('Dob: ${newContact.dob}');
      print('Lycee: ${newContact.lycee}');
      print('Email: ${newContact.email}');
      print('Classes: ${newContact.classes}');
      print('========================================');
      print('Submitting to back end...');
      print('TODO - we will write the submission part next...');
    }
  }

  void showMessage(String message) {
    print("Probleme");
    //_formKey.currentState
    //    .showSnackBar(new SnackBar(content: new Text(message)));
  }
}

bool isValidEmail(String input) {
  final RegExp regex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  return regex.hasMatch(input);
}

bool isValidDob(String dob) {
  if (dob.isEmpty) return true;
  var d = convertToDate(dob);
  return d != null && d.isBefore(new DateTime.now());
}

class Contact {
  String name;
  DateTime dob;
  String lycee = '';
  String email = '';
  List<String> classes = [''];
}

DateTime convertToDate(String input) {
  try {
    var d = new DateFormat.yMd().parseStrict(input);
    return d;
  } catch (e) {
    return null;
  }
}
