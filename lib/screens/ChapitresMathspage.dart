import 'package:flashcards/screens/WorkMode.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';


class ChapitresMaths extends StatefulWidget {
  final String filiere;
  ChapitresMaths(this.filiere);
  @override
  State<StatefulWidget> createState() {
    return _ChapitresMathsState(this.filiere);
  }
}

class _ChapitresMathsState extends State<ChapitresMaths> {
  String filiere;
  String nomChapitre;
  Map<String, List<String>> mapChapitresPCSI={"Analyse":["Analyse SUP","Equa diff","EVN","Fonctions de plusieurs variables",
  "Intégration","Primitives","Séries entières","Séries numériques","Suites de fonction","Suites numériques","Formules trigo"],
  "Algèbre":["Algèbre linéaire 1","Algèbre linéaire 2","Réduction","Algèbre bilinéaire"],
  "Probabilités":["Proba discrètes","Proba discrètes","VA finies","VA discrètes"]};

  Map<String, List<String>> mapChapitresPSI={"Analyse":["Analyse SUP","Equa diff","EVN","Fonctions de plusieurs variables",
  "Intégration","Primitives","Séries entières","Séries numériques","Suites de fonction","Suites numériques","Formules trigo"],
  "Algèbre":["Algèbre linéaire 1","Algèbre linéaire 2","Réduction","Algèbre bilinéaire"],
  "Probabilités":["Proba discrètes","Proba discrètes","VA finies","VA discrètes"]};
  
  Map<String, Map<String, List<String>> > mapChapitres={"PCSI":{"Analyse":["01 Analyse SUP","02 Suites numériques","03 Séries numériques",
  "04 Suites de fonction","05 Séries entières","06 Primitives","07 Equations différentielles","08 Intégration","09 Lebesgue","10 Intégrales à paramètre"
  ,"11 EVN","12 Fonctions de plusieurs variables",   "13 Trigonométrie"],
  "Algèbre":["01 Algèbre linéaire 1","02 Algèbre linéaire 2","03 Réduction","04 Algèbre bilinéaire"],
  "Probabilités":["01 Proba discrètes","02 VA finies","03 Proba discrètes","04 VA discrètes"]}
  ,"PSI":{"Analyse":["01 Analyse SUP","02 Suites numériques","03 Séries numériques",
  "04 Suites de fonction","05 Séries entières","06 Primitives","07 Equations différentielles","08 Intégration","09 Lebesgue","10 Intégrales à paramètre"
  ,"11 EVN","12 Fonctions de plusieurs variables",   "13 Trigonométrie"],
  "Algèbre":["01 Algèbre linéaire 1","02 Algèbre linéaire 2","03 Réduction","04 Algèbre bilinéaire"],
  "Probabilités":["01 Proba discrètes","02 VA finies","03 Proba discrètes","04 VA discrètes"]}};

  _ChapitresMathsState(this.filiere);
  @override
  Widget build(BuildContext context) {
    MaterialApp appChap = MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: TabBar(
              tabs: [
                Tab(text: "Analyse"),
                Tab(text:"Algèbre"),
                Tab(text: "Probabilités"),
              ],
            ),
            //title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [

              new Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: this.mapChapitres[this.filiere]["Analyse"].length,
                  itemBuilder: (BuildContext context, int index) {
                    final listTile = ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(
                                    width: 1.0, color: Colors.black))),
                        child: Icon(Icons.autorenew, color: Colors.black),
                      ),
                      title: Text(
                        this.mapChapitres[this.filiere]["Analyse"][index],
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                      // subtitle: Row(
                      //   children: <Widget>[
                      //     Icon(Icons.add, color: Colors.lightBlue),
                      //     Text(snapshot.data[index][1],
                      //         style: TextStyle(color: Colors.black))
                      //   ],
                      // ),
                      trailing: Icon(Icons.keyboard_arrow_right,
                          color: Colors.black, size: 30.0),
                      onTap: () =>
                      {
                         _openPage((_) => new WorkMode("Analyse"+"-"+ this.mapChapitres[this.filiere]["Analyse"][index],this.filiere+"Maths"))
                      },
                    );
                    
                    final list = Card(
                      elevation: 8.0,
                      margin: new EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: Container(
                        decoration:
                        BoxDecoration(color: Colors.grey.withAlpha(18)),
                        child: listTile,
                      ),
                    );
                    return list;
                  }
                )
              )
              ,
              new Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: this.mapChapitres[this.filiere]["Algèbre"].length,
                  itemBuilder: (BuildContext context, int index) {
                    final listTile = ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(
                                    width: 1.0, color: Colors.black))),
                        child: Icon(Icons.autorenew, color: Colors.black),
                      ),
                      title: Text(
                        this.mapChapitres[this.filiere]["Algèbre"][index],
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                      // subtitle: Row(
                      //   children: <Widget>[
                      //     Icon(Icons.add, color: Colors.lightBlue),
                      //     Text(snapshot.data[index][1],
                      //         style: TextStyle(color: Colors.black))
                      //   ],
                      // ),
                      trailing: Icon(Icons.keyboard_arrow_right,
                          color: Colors.black, size: 30.0),
                      onTap: () =>
                      {
                        _openPage((_) => new WorkMode("Algèbre"+"-"+ this.mapChapitres[this.filiere]["Algèbre"][index],this.filiere+"Maths"))

                      },
                    );
                    
                    final list = Card(
                      elevation: 8.0,
                      margin: new EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: Container(
                        decoration:
                        BoxDecoration(color: Colors.grey.withAlpha(18)),
                        child: listTile,
                      ),
                    );
                    return list;
                  }
                )
              )
              ,
              new Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: this.mapChapitres[this.filiere]["Probabilités"].length,
                  itemBuilder: (BuildContext context, int index) {
                    final listTile = ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(
                                    width: 1.0, color: Colors.black))),
                        child: Icon(Icons.autorenew, color: Colors.black),
                      ),
                      title: Text(
                        this.mapChapitres[this.filiere]["Probabilités"][index],
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                      // subtitle: Row(
                      //   children: <Widget>[
                      //     Icon(Icons.add, color: Colors.lightBlue),
                      //     Text(snapshot.data[index][1],
                      //         style: TextStyle(color: Colors.black))
                      //   ],
                      // ),
                      trailing: Icon(Icons.keyboard_arrow_right,
                          color: Colors.black, size: 30.0),
                      onTap: () =>
                      {
                        _openPage((_) => new WorkMode("Probabilités"+"-"+ this.mapChapitres[this.filiere]["Probabilités"][index],this.filiere+"Maths"))
 
                      },
                    );
                    
                    final list = Card(
                      elevation: 8.0,
                      margin: new EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: Container(
                        decoration:
                        BoxDecoration(color: Colors.grey.withAlpha(18)),
                        child: listTile,
                      ),
                    );
                    return list;
                  }
                )
              ),
            ],
        ),
      ),
    )

    
    );
    // if (Platform.isIOS) {
    //   // return CupertinoPageScaffold(child: Column(children: content,),navigationBar: CupertinoNavigationBar(leading: Text("Accueil"),),);
    //   content.add(CupertinoNavigationBar(
    //     middle: Text("Flashcards"), transitionBetweenRoutes: false,));
    // }


    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text("Chapitres Maths"),
      ),
      iosContentPadding: true,
      body:Center(
        child: appChap
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