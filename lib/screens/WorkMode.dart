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
  WorkMode(this.dataflc, this.filierematiere);
  @override
  State<StatefulWidget> createState() {
    return _WorkMode(this.dataflc, this.filierematiere);
  }
}

class _WorkMode extends State<WorkMode> {
  final String dataflc;
  final String filierematiere;
  GlobalKey<ScaffoldState> _key = GlobalKey();
  List<bool> notions = [true,false,false,false];
  _WorkMode(this.dataflc, this.filierematiere);
  @override
  Widget build(BuildContext context) {
    Widget listNiveau = new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Choix des notions à afficher"),
        // [Monday] checkbox
        Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Checkbox(
                value: notions[0],
                onChanged: (bool value) {
                  setState(() {
                    notions[0] = value;
                  });
                },
              ),
              Text("Notions très importantes"),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Checkbox(
                value: notions[1],
                onChanged: (bool value) {
                  setState(() {
                    notions[1] = value;
                  });
                },
              ),
              Text("Notions complémentaires"),
            ]),
          Row(mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Checkbox(
                value: notions[2],
                onChanged: (bool value) {
                  setState(() {
                    notions[2] = value;
                  });
                },
              ),
              Text("Notions occasionnelles"),
            ]),
                      Row(mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Checkbox(
                value: notions[3],
                onChanged: (bool value) {
                  setState(() {
                    notions[3] = value;
                  });
                },
              ),
              Text("Notions rares"),
            ]),
        ]),
      ],
    );

    Widget buttonDecouverte = new Container(
      margin: marginContainer,
      child: new RaisedButton(
          padding: paddingButton,
          child: new Text("Découverte", style: styleMatiere),
          onPressed: () {
            _openPage((_) =>
                new ConseilDecouverte(this.dataflc, this.filierematiere));
          }),
    );

    Widget buttonApprentissage = new Container(
      margin: marginContainer,
      child: new RaisedButton(
          padding: paddingButton,
          child: new Text("Apprentissage", style: styleMatiere),
          onPressed: () {
            _openPage((_) =>
                new ConseilApprentissage(this.dataflc, this.filierematiere));
          }),
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
          child: new Text("Révision", style: styleMatiere),
          onPressed: () {
            final bar = _snackSample();
            _key.currentState.showSnackBar(bar);
          }),
    );

    Widget modesMaths = new Scaffold(
      key: _key,
      body: new Center(
        child: Padding(
          padding: paddingPage,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              listNiveau,
              buttonDecouverte,
              buttonApprentissage,
              buttonRevision
            ],
          ),
        ),
      ),
    );

    Widget modesSI = new Scaffold(
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

    if (this.filierematiere.contains("Maths")){
      return PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text("Choix du mode"),
        ),
        iosContentPadding: true,
        body: Center(
          child: modesMaths,
        ),
      );
    }
    else {      
      return PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text("Choix du mode"),
        ),
        iosContentPadding: true,
        body: Center(
          child: modesSI,
        ),
      );}
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
