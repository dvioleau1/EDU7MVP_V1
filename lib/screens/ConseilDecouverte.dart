import 'dart:io';
import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flashcards/screens/const_global.dart';
import 'package:flashcards/screens/FlashCardDecouverte.dart';
import 'package:flashcards/screens/FlashCardDecouverteMathsPSI.dart';

import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ConseilDecouverte extends StatefulWidget {
  final String dataflc;
  final String filierematiere;
  ConseilDecouverte(this.dataflc,this.filierematiere);

  @override
  State<StatefulWidget> createState() {
    return _ConseilDecouverteState(this.dataflc,this.filierematiere);
  }
}

class _ConseilDecouverteState extends State<ConseilDecouverte> {    
  final String dataflc;
  final String filierematiere;
  _ConseilDecouverteState(this.dataflc,this.filierematiere);
  @override
  Widget build(BuildContext context) {
    List<Widget> content = [];
  var widthSize = MediaQuery
        .of(context)
        .size
        .width;
    var heightSize = MediaQuery
        .of(context)
        .size
        .height;

    if (Platform.isIOS) {
      // return CupertinoPageScaffold(child: Column(children: content,),navigationBar: CupertinoNavigationBar(leading: Text("Accueil"),),);
      content.add(CupertinoNavigationBar(middle: Text("Conseil Découverte")));
    }

Widget buttonStart = new Container(
      margin: marginContainer,
      child: new RaisedButton(
          padding: paddingButton,
          child: new Text(
              "OK, j'ai compris",
              style: TextStyle(fontSize: 20.0,)
          ),
          onPressed:(){
              if (this.filierematiere=="PSIMaths") { _openPage((_) =>
                new FlashCardDecouverteMathsPSI( this.dataflc,this.filierematiere));}
                else {_openPage((_) =>
                new FlashCardDecouverte(this.dataflc,this.filierematiere));}

          }
      ),
    );
           final info = Card(
                          elevation: 8.0,
                          margin: new EdgeInsets.symmetric(
                              horizontal:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.05,
                              vertical:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.10),
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.04 * heightSize,
                                  horizontal: 0.04 * widthSize),
                              decoration: BoxDecoration(
                                  color: Colors.grey.withAlpha(18),borderRadius: BorderRadius.circular(15)),
                              width: MediaQuery.of(context).size.width*0.8,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween ,
                                children: <Widget>[

                                //Pour associer textes et images
                                Wrap(spacing: 5.0, // gap between adjacent chips
                                runSpacing: 5.0, // gap between lines
                                alignment:WrapAlignment.center,crossAxisAlignment:WrapCrossAlignment.center,
                                    children: <Widget>[
                                      Text('Découvre les notions importantes',textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                      Text(''),
                                      Text('Swipe vers la gauche (ou droite) pour changer de notions',textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                      Text(''),
                                      Image.asset('images/swipe.png',height: 70,width: 70),
                                      buttonStart
                                    ],
                                  ),
                                ],
                              )
                          )
                    );


    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text("Conseils"),
      ),
      iosContentPadding: true,
      body:Center(
        child: info,
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
