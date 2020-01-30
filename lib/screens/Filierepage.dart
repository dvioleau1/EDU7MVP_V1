import 'dart:io';
import 'package:flashcards/screens/const_global.dart';
import 'package:flashcards/screens/Matierepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class Filierepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FilierepageState();
  }
}

class _FilierepageState extends State<Filierepage> {
// class Filierepage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<Widget> content = [];
  

    if (Platform.isIOS) {
      // return CupertinoPageScaffold(child: Column(children: content,),navigationBar: CupertinoNavigationBar(leading: Text("Accueil"),),);
      content.add(CupertinoNavigationBar(middle: Text("Flashcards")));
    }


    Widget buttonPCSI = new Container(
      margin: marginContainer,
      child: new RaisedButton(
          padding: paddingButton,
          child: new Text(
            "PCSI",
            style: styleFiliere
          ),

          onPressed:(){
           _openPage((_) =>
                       new FilierePCSI("PCSI"));
          }
          
      ),
    );

    Widget buttonPSI = new Container(
      margin: marginContainer,
      child: new RaisedButton(
          padding: paddingButton,
          child: new Text(
              "PSI",
              style: styleFiliere
          ),
          onPressed:(){
           _openPage((_) =>
                       new FilierePSI("PSI"));
          }
      ),
    );

    Widget choixFiliere = new Center(
      child: Padding(
        padding: paddingPage,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buttonPCSI,
            buttonPSI,
          ],
        ),
      ),
    );

    //return choixFiliere;
    return PlatformScaffold(
      iosContentPadding: true,
      body:Center(
        child: choixFiliere,
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

