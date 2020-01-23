import 'dart:convert';
import 'dart:ui';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter/services.dart' show rootBundle;

class FlashCard extends StatefulWidget {
  final String category;
  final String filierematiere;
  //final List<List<String>> allFlashCards;

  FlashCard(this.category,this.filierematiere);

  @override
  State<StatefulWidget> createState() {
    _FlashCardState stateFlc=_FlashCardState(category,filierematiere);
    stateFlc.category=category;
    stateFlc.filierematiere=filierematiere;
    //stateFlc.allFlashCards=allFlashCards;
    return stateFlc;
  }

}

class _FlashCardState extends State<FlashCard> with TickerProviderStateMixin {
  String category;
  String filierematiere;
  List<List<String>> allFlashCards;

  ScrollController _smoothScrollController;

  _FlashCardState(category,filierematiere);

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
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Press button to start.');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Text('Awaiting result...');
          case ConnectionState.done:
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
                    final list = FlipCard(
                        front: Card(
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
                              
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween ,
                                children: <Widget>[
                                  //affichage du niveau d'importance ***, **, *
                                  Text(
                                    //"Importance "+snapshot.data[index][0],
                                    "Importance ***",
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                           
                                    Image.asset("Images"+filierematiere+"/"+snapshot.data[index][1],height: 300,width: 300),
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
                              )),
                        ),
                        back: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Card(
                              elevation: 8.0,

                              margin: new EdgeInsets.symmetric(
                                  horizontal:
                                  widthSize * 0.05,
                                  vertical: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.10),

                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                  vertical: 0.01 * heightSize,
                                  horizontal: 0.01 * widthSize),                                  
                                  color: background.evaluate(
                                      AlwaysStoppedAnimation(
                                          _controller.value)),
                                  child: Column(
                                    crossAxisAlignment:CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween ,

                                    children: <Widget>[
                                      Text(
                                        "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      
                                      Image.asset("Images"+filierematiere+"/"+snapshot.data[index][2],height: 300,width: 300),
                                      // Text(
                                      //   snapshot.data[index][2],
                                      //   textAlign: TextAlign.center
                                      // ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                              "La Flashcard est-elle maîtrisée ?"),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              RaisedButton(
                                                child: Icon(Icons
                                                    .sentiment_very_dissatisfied),
                                                onPressed: () {
                                                  _controller.forward(
                                                      from: _controller
                                                          .lowerBound);
                                                  _controller.animateTo(0.33);
                                                  moveToNextCard();
                                                },
                                              ),
                                              RaisedButton(
                                                child: Icon(
                                                    Icons.sentiment_neutral),
                                                onPressed: () {
                                                  _controller.forward(
                                                      from: 0.34);
                                                  _controller.animateTo(0.66);
                                                  moveToNextCard();
                                                },
                                              ),
                                              RaisedButton(
                                                child: Icon(Icons
                                                    .sentiment_very_satisfied),
                                                onPressed: () {
                                                  _controller.forward(
                                                      from: 0.67);
                                                  _controller.animateTo(1);
                                                  moveToNextCard();
                                                },
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  )),
                            );
                          },
                        ));
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
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Text("Erreur dans le chargement")],
              );
            }
        }
      },
    );

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text("Mode Apprentissage"),
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
    print(category);
    print(filierematiere);
    //Map<String, String> nameFiles = {"Algèbre-Algèbre bilinéaire":"AAB.json","Algèbre-Algèbre linéaire 1":"AAL1.json"};
    //String nameFile=nameFiles[category];
    //
    String nameFile="Flc"+filierematiere+"/"+category+".json";
    print(nameFile);
    final String data= await rootBundle.loadString(nameFile);
    return convertDatas(data);

  }
  //   static Future getAllFlashCards(String category) async {
  //   //get datas from json file
  //   final String data= await rootBundle.loadString('images/test.json');
  //   //TODO : Ajouter la gestion d'erreur
  //   print("flashcards download ");
  //    String url =
  //        "http://www.cookie-build.com/Flashcards/Get_Cards.php"; //?categories=" +category;
  //    final response = await http.get(url);
  //   // print(response.body) ;
  //   return jsonDecode(response.body);

  // }

  static Future convertDatas(String data) async {
    //lecture json et extraction des donnees pour les convertir en listArray
    //on peut certainement faire directement
    Map<String, dynamic> datajson = jsonDecode(data);
    List<dynamic> listArray = [];
    for (int i = 0; i < datajson["flc"].length; i++){
        String enonce=(datajson["flc"][i]["enonce"]) ;
        String title=(datajson["flc"][i]["importance"]) ;
        String corrige=(datajson["flc"][i]["corrige"]) ;
        listArray.add([ title,enonce,corrige]);
    }
    return listArray;
  }

}

