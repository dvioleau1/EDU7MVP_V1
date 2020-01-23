
import 'package:flashcards/screens/WorkMode.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';



class ChapitresSI extends StatefulWidget {
  final String filiere;
  ChapitresSI(this.filiere);
  @override
  State<StatefulWidget> createState() {
    return _ChapitresSIState(this.filiere);
  }
}

class _ChapitresSIState extends State<ChapitresSI> {
  String filiere;
  String nomChapitre;

  Map<String, List<String>> mapChapitresPCSI={"Mécanique":["Modélisation des mécanismes","Cinématique","Transmetteurs",
   "Modélisation des actions mécaniques",  "Statique"],
  "Automatique":["Modélisation des SLCI","Calculs des SLCI"],
  "SED":["Logique","SysML"]};

  Map<String, List<String>> mapChapitresPSI={"Mécanique":["Hyperstatisme","Dynamique","Energétique"],
  "Automatique":["Performances des SLCI","Correcteurs"],
  "SED":[""]};
  
  Map<String, Map<String, List<String>> > mapChapitres={"PCSI":{"Mécanique":["Modélisation des mécanismes","Cinématique","Transmetteurs",
  "Modélisation des actions mécaniques",  "Statique"],
  "Automatique":["Modélisation des SLCI","Calculs des SLCI"],
  "SED":["Logique","SysML"]}
  ,"PSI":{"Mécanique":["Hyperstatisme","Dynamique","Energétique"],
  "Automatique":["Performances des SLCI","Correcteurs"],
  "SED":[""]}};

  _ChapitresSIState(this.filiere);
  @override
  Widget build(BuildContext context) {
    MaterialApp appChap = MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: TabBar(
              tabs: [
                Tab(text: "Mécanique"),
                Tab(text: "Automatique"),
                Tab(text: "SED"),
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
                  itemCount: this.mapChapitres[this.filiere]["Mécanique"].length,
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
                        this.mapChapitres[this.filiere]["Mécanique"][index],
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
                         _openPage((_) => new WorkMode("Mécanique"+"-"+ this.mapChapitres[this.filiere]["Mécanique"][index],this.filiere+"SI"))
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
                  itemCount: this.mapChapitres[this.filiere]["Automatique"].length,
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
                        this.mapChapitres[this.filiere]["Automatique"][index],
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
                        _openPage((_) => new WorkMode("Automatique"+"-"+ this.mapChapitres[this.filiere]["Automatique"][index],this.filiere+"SI"))

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
                  itemCount: this.mapChapitres[this.filiere]["SED"].length,
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
                        this.mapChapitres[this.filiere]["SED"][index],
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
                        _openPage((_) => new WorkMode("SED"+"-"+ this.mapChapitres[this.filiere]["SED"][index],this.filiere+"SI"))
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
        title: Text("Chapitres SI"),
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