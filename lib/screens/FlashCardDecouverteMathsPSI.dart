import 'dart:convert';
import 'dart:ui';
import 'dart:io' as io;

import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
//import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
//import 'package:extended_text/extended_text.dart';

Map<int,String> importance={1:"Notion très importante",2:"Notion complémentaire",3:"Notion occasionnelle",4:"Notion très rare"};

class FlashCardDecouverteMathsPSI extends StatefulWidget {
  final String category;
  final String filierematiere;
  //final List<List<String>> allFlashCards;

  FlashCardDecouverteMathsPSI(this.category,this.filierematiere);

  @override
  State<StatefulWidget> createState() {
    _FlashCardDecouverteMathsPSIState stateFlc=_FlashCardDecouverteMathsPSIState(category,filierematiere);
    stateFlc.category=category;
    stateFlc.filierematiere=filierematiere;
    //stateFlc.allFlashCards=allFlashCards;
    return stateFlc;
  }

}

class _FlashCardDecouverteMathsPSIState extends State<FlashCardDecouverteMathsPSI> with TickerProviderStateMixin {
  String category;
  String filierematiere;
  List<List<String>> allFlashCards;

  ScrollController _smoothScrollController;

  _FlashCardDecouverteMathsPSIState(category,filierematiere);

  @override
  void initState() {
    super.initState();
    _smoothScrollController = ScrollController();
  }


   /// Center cards when releasing
  void _scrollListener() {
    print(_smoothScrollController.offset);

    var widthSize = MediaQuery
        .of(context)
        .size
        .width;
    widthSize *= 0.88;
    if (_smoothScrollController.offset % widthSize > 1 &&
        _smoothScrollController.offset <
            _smoothScrollController.position.maxScrollExtent) {
      if (_smoothScrollController.offset % widthSize > 1 / 2 * widthSize) {
        Future.delayed(Duration(milliseconds: 100), () {
          _smoothScrollController.animateTo(
              _smoothScrollController.offset +
                  widthSize -
                  (_smoothScrollController.offset % widthSize),
              duration: Duration(milliseconds: 100),
              curve: Curves.linear);
        });
      } else {
        Future.delayed(Duration(milliseconds: 100), () {
          _smoothScrollController.animateTo(
              _smoothScrollController.offset -
                  widthSize +
                  (widthSize - _smoothScrollController.offset % widthSize),
              duration: Duration(milliseconds: 100),
              curve: Curves.linear);
        });
      }
    }
  }

  /// Move to the next card with a linear animation
  
  void moveToNextCard() {
    var widthSize = MediaQuery
        .of(context)
        .size
        .width;
    widthSize *= 0.88;
    Future.delayed(Duration(milliseconds: 500), () {
      _smoothScrollController.animateTo(
          _smoothScrollController.offset + widthSize,
          duration: Duration(milliseconds: 200), curve: Curves.linear);
    });
  }

  @override
  Widget build(BuildContext context) {
    var widthSize = MediaQuery
        .of(context)
        .size
        .width;
    var heightSize = MediaQuery
        .of(context)
        .size
        .height;



    Animatable<Color> background = TweenSequence<Color>(
      [
        TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(
            begin: Colors.grey.withAlpha(18),
            end: Colors.red,
          ),
        ),
        TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(
            begin: Colors.grey.withAlpha(18),
            end: Colors.orangeAccent,
          ),
        ),
        TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(
            begin: Colors.grey.withAlpha(18),
            end: Colors.green,
          ),
        ),
      ],
    );

    // Get the flashcards content and display them as a list
    FutureBuilder futureBuilder = FutureBuilder(
      future: getAllFlashCards(category,filierematiere),
      builder: (context, snapshot) {
        // switch (snapshot.connectionState) {
        //   case ConnectionState.none:
        //     return Text('Press button to start.');
        //   case ConnectionState.active:
        //   case ConnectionState.waiting:
        //     return Text('Awaiting result...');
        //   case ConnectionState.done:
            if (snapshot.hasData) {
              
              final makeBody = Container(
                alignment: Alignment.center,
                padding: new EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _smoothScrollController,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: MediaQuery
                          .of(context)
                          .size
                          .width * 0.05),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    AnimationController _controller = AnimationController(
                        duration: const Duration(seconds: 1),
                        vsync: this,
                        animationBehavior: AnimationBehavior.normal);
                    _controller.animateTo(_controller.lowerBound);
                    final list = Card(
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
                                  .height * 0.05),
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.04 * heightSize,
                                  horizontal: 0.04 * widthSize),
                              decoration: BoxDecoration(
                                  color: Colors.grey.withAlpha(18),borderRadius: BorderRadius.circular(15)),
                              
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween ,
                                children: <Widget>[
                                  //affichage du niveau d'importance ***, **, *
                                  Row(mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(""),
                                              Text( importance[snapshot.data[index][0]],
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  )                                  ,  
                                  

                                  IconButton(
        icon: Icon(Icons.apps),
        tooltip: 'Affiche l\'ensemble des notions de cette catégories',
        onPressed: () {            final snackBar = SnackBar(
                        content: Text('Retrouve ici une vue d\'ensemble de toutes les flashcards pour un même niveau d\'importance'),
            );
            Scaffold.of(context).showSnackBar(snackBar);}
          ),
          
                                            ]),
                                            Divider(thickness:1, color:Colors.black ),
                                  Text(snapshot.data[index][1],textAlign: TextAlign.center),
                                    Divider(thickness:1, color:Colors.black ),
                                    Image.asset("images/Images"+filierematiere+"/"+snapshot.data[index][2],height: 200,width: 300),
                                    //Image.asset("Images"+filierematiere+"/A.png",height: 200,width: 300),

                                // //Pour associer textes et images
                                // Wrap(spacing: 2.0, // gap between adjacent chips
                                // runSpacing: 1.0, // gap between lines
                                // alignment:WrapAlignment.center,crossAxisAlignment:WrapCrossAlignment.center,
                                //     children: <Widget>[
                                //       Text('Voici une formule '),
                                //       Image.asset('images/test1.png',height: 60,width: 60),
                                //       Text(' suivi de'),
                                //       Image.asset('images/test1.png',height: 60,width: 60),
                                //       Text(' et enfin '),
                                //       Image.asset('images/test1.png',height: 60,width: 60),
                                //     ],
                                //   ),
           
                                  //Image.asset('images/test1.png',height: 100,width: 100),
                                  //affichage de l'enonce de la question
                                  //Text(snapshot.data[index][1],textAlign: TextAlign.center),
                                  //affichage du numero de flashcard
                                  Text((index + 1).toString() +
                                      "/" +
                                      snapshot.data.length.toString())
                                ],
                              )
                          )
                    );

                    return Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.64,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.88,
                      child: list,
                    );
                  },
                ),
              );

              return makeBody;
            } 
            else if (snapshot.hasError) {
              return new Text("${snapshot.error}");
            }
            // else {
            //   return Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[Text("Erreur dans le chargement")],
            //   );
            // }
            return new CircularProgressIndicator();
        }
      
    );

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text("Mode découverte"),
      ),
      iosContentPadding: true,
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollEndNotification) {
            _scrollListener();
          }

          // Returning null (or false) to
          // "allow the notification to continue to be dispatched to further ancestors".
          return null;
        },
        child: futureBuilder,
      ),
    );
  }

  /// Get flashcards for a category as a list
  
  static Future getAllFlashCards(String category,String filierematiere) async {
    //get datas from json file
    String nameFile="ressources/Flc"+filierematiere+"/"+category;
    Future datas;
          //String nameFile="./Flc"+filierematiere+"/A1.json";

    final String data= await rootBundle.loadString(nameFile);
    datas=convertDatas(data);
    return datas;
    

  }


  static Future convertDatas(String data) async {
    //lecture json et extraction des donnees pour les convertir en listArray
    //on peut certainement faire directement
    Map<String, dynamic> datajson = jsonDecode(data);
    List<dynamic> listArray = [];
    for (int i = 0; i < datajson["flc"].length; i++){
        String enonce=(datajson["flc"][i]["enonce"]) ;
        int title=(datajson["flc"][i]["importance"]) ;
        String corrige=(datajson["flc"][i]["corrige"]) ;
        listArray.add([ title,enonce,corrige]);
    }
    return listArray;
  }

}

