import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flashcards/screens/const_global.dart';
import 'package:flashcards/screens/ChapitresMathspage.dart';
import 'package:flashcards/screens/ChapitresSIpage.dart';

import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';


class FilierePCSI extends StatefulWidget {
  final String filiere;
  FilierePCSI(this.filiere);
  @override
  State<StatefulWidget> createState() {
    return PCSI(this.filiere);
  }
}

class PCSI extends State<FilierePCSI> {
  final String filiere;
  PCSI(this.filiere);
  @override
  Widget build(BuildContext context) {

    Widget buttonMathsPCSI = new Container(
      margin: marginContainer,
      child: new RaisedButton(
          padding: paddingButton,
          child: new Text(
              "Mathématiques",
              style: styleMatiere
          ),
          onPressed:(){
            _openPage((_) =>
              new ChapitresMaths("PCSI"));
          }
      ),
    );

    Widget buttonSIPCSI = new Container(
      margin: marginContainer,
      child: new RaisedButton(
          padding: paddingButton,
          child: new Text(
              "SI",
              style: styleMatiere
          ),
          onPressed:(){
            _openPage((_) =>
              new ChapitresSI("PCSI"));
          }
      ),
    );

    Widget matierePCSI = new Scaffold(
      body: new Center(
        child: Padding(
          padding: paddingPage,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[
              buttonMathsPCSI,
              buttonSIPCSI,
            ],
          ),
        ),
      ),
    );

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(filiere+" - Matière"),
      ),
      iosContentPadding: true,
      body:Center(
        child: matierePCSI,
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


class FilierePSI extends StatefulWidget {
  final String filiere;
  FilierePSI(this.filiere);
  @override
  State<StatefulWidget> createState() {
    return PSI(this.filiere);
  }
}

class PSI extends State<FilierePSI> {
  final String filiere;
  PSI(this.filiere);
  @override
  Widget build(BuildContext context) {

    Widget buttonMathsPSI = new Container(
      margin: marginContainer,
      child: new RaisedButton(
          padding: paddingButton,
          child: new Text(
              "Mathématiques",
              style: styleMatiere
          ),
          onPressed:(){
            _openPage((_) =>
              new ChapitresMaths("PSI"));
          }
          ),
    );

    Widget buttonSIPSI = new Container(
      margin: marginContainer,
      child: new RaisedButton(
          padding: paddingButton,
          child: new Center(child:new Text(
              "SI",
              style: styleMatiere
          )),
          onPressed:(){
            _openPage((_) =>
              new ChapitresSI("PSI"));
          }
          ),
    );


    Widget matierePSI = new Scaffold(
      body: new Center(
        child: Padding(
          padding: paddingPage,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[
              buttonMathsPSI,
              buttonSIPSI,
            ],
          ),
        ),
      ),
    );

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(filiere+" - Matière"),
      ),
      iosContentPadding: true,
      body:Center(
        child: matierePSI,
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
