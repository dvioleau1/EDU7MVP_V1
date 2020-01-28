import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class Exercicepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Exercicepage();
  }
}

class _Exercicepage extends State<Exercicepage> {
    @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding( padding: const EdgeInsets.all(16.0), child: Text("A venir. Ensembles d'exercices classés par difficultés adaptés à chaque profil"),)
    );


  }
  // @override
  // Widget build(BuildContext context) {
  //   List<Widget> content = [];


  //   if (Platform.isIOS) {
  //     // return CupertinoPageScaffold(child: Column(children: content,),navigationBar: CupertinoNavigationBar(leading: Text("Accueil"),),);
  //     content.add(CupertinoNavigationBar(middle: Text("Exercices")));
  //   }

  //   Widget msg = new Center(
  //     child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: <Widget>[
  //           new Text("A venir. Ensembles d'exercices classés par difficultés adaptés à chaque profil" ,style: TextStyle(
  //                                           fontWeight: FontWeight.bold, fontSize: 20),),
  //           //new Text("Créé par et pour des Prépas"),
  //         ],
  //       ),
  //     );
  //    return msg;

  // }
}
