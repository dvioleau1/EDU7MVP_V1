import 'dart:io';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';


class Homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomepageState();
  }
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> content = [];


    if (Platform.isIOS) {
      // return CupertinoPageScaffold(child: Column(children: content,),navigationBar: CupertinoNavigationBar(leading: Text("Accueil"),),);
      content.add(CupertinoNavigationBar(middle: Text("Accueil")));
    }

//return Scaffold(
  // appBar: AppBar(
  //   title: Text("ListView"),
  // ),
//   body: Container(
//     child: CustomScrollView(
//       slivers: <Widget>[
//         SliverList(
//           delegate: SliverChildListDelegate(
//             [
//               HeaderWidget("Header 1",Colors.blue),
//               HeaderWidget("Header 2",Colors.red),
//               HeaderWidget("Header 3",Colors.green),
//               HeaderWidget("Header 4",Colors.orange),
//               HeaderWidget("Header 5",Colors.blue),
//               HeaderWidget("Header 6",Colors.red),
//             ],
//           ),
//         )
//         // SliverGrid(
//         //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         //   delegate: SliverChildListDelegate(
//         //     [
//         //       BodyWidget(Colors.blue),
//         //       BodyWidget(Colors.green),
//         //       BodyWidget(Colors.yellow),
//         //       BodyWidget(Colors.orange),
//         //       BodyWidget(Colors.blue),
//         //       BodyWidget(Colors.red),
//         //     ],
//         //   ),
//         // ),
//       ],
//     ),
//   ),
// );
    Widget accueil = new Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Text("Bienvenue sur EDU7" ,style: TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 20),),
            new Image.asset("images/Image_accueil.png",height: 200,width: 200),
            new Text("Créé par et pour des Prépas"),
          ],
        ),
      );
     //content.add(Text("Page d'accueil"));
     return accueil;

  }
}

class HeaderWidget extends StatelessWidget {
  final String text;
  final Color color;

  HeaderWidget(this.text,this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text(text),
      color: color,
      height: 100.0,
      alignment: Alignment.center,
    );
  }
}
