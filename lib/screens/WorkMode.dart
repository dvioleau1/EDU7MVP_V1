import 'dart:io';
import 'package:flashcards/screens/ConseilDecouverte.dart';
import 'package:flashcards/screens/ConseilApprentissage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flashcards/screens/const_global.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';


class WorkMode extends StatefulWidget {
  final String dataflc;
  final String filierematiere;
  WorkMode(this.dataflc,this.filierematiere);
  @override
  State<StatefulWidget> createState() {
    return _WorkMode(this.dataflc,this.filierematiere);
  }
}

class _WorkMode extends State<WorkMode> {
  final String dataflc;
  final String filierematiere;
  GlobalKey<ScaffoldState> _key = GlobalKey();
  _WorkMode(this.dataflc,this.filierematiere);
  @override
  Widget build(BuildContext context) {

    Widget buttonDecouverte = new Container(
      margin: marginContainer,
      child: new RaisedButton(
          padding: paddingButton,
          child: new Text(
              "Découverte",
              style: styleMatiere
          ),
          onPressed:(){
            _openPage((_) =>
                new ConseilDecouverte(this.dataflc, this.filierematiere));
          }
      ),
    );

    Widget buttonApprentissage = new Container(
      margin: marginContainer,
      child: new RaisedButton(
          padding: paddingButton,
          child: new Text(
              "Apprentissage",
              style: styleMatiere
          ),
          onPressed:(){
             _openPage((_) =>
            new ConseilApprentissage(this.dataflc, this.filierematiere));
          }
      ),
    );
         Widget _snackSample() => SnackBar(
        content: Text(
          "Fonctionnalité à venir : flashcards à traiter avec chronomètre",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.blue,
      );

        Widget buttonRevision = new Container(
      margin: marginContainer,
      child: new RaisedButton(
          padding: paddingButton,
          child: new Text(
              "Révision",
              style: styleMatiere
          ),
          onPressed:(){
            final bar = _snackSample();
            _key.currentState.showSnackBar(bar);
          }
      ),
    );

    Widget modes = new Scaffold(
      key: _key,
      body: new Center(
        child: Padding(
          padding: paddingPage,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[
              buttonDecouverte,
              buttonApprentissage,
              buttonRevision
            ],
          ),
        ),
      ),
    );

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text("Choix du mode"),
      ),
      iosContentPadding: true,
      body:Center(
        child: modes,
      ),
    );
    
  }
    _openPage(WidgetBuilder pageToDisplayBuilder) {
    Navigator.push(
      context,
      platformPageRoute(
        context: context,
        builder: pageToDisplayBuilder,

      ),
    );

  }
  
}
