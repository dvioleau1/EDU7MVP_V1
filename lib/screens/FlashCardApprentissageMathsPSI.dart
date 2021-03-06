import 'dart:convert';
import 'dart:ui';
import 'dart:io' as io;

import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter/services.dart' show rootBundle;

Map<int,String> importance={1:"Notion très importante",2:"Notion complémentaire",3:"Notion occasionnelle",4:"Notion très rare"};

class FlashCard2 extends StatefulWidget {
  final String category;
  final String filierematiere;
  //final List<List<String>> allFlashCards;

  FlashCard2(this.category,this.filierematiere);

  @override
  State<StatefulWidget> createState() {
    _FlashCard2State stateFlc=_FlashCard2State(category,filierematiere);
    stateFlc.category=category;
    stateFlc.filierematiere=filierematiere;
    //stateFlc.allFlashCards=allFlashCards;
    return stateFlc;
  }

}

class _FlashCard2State extends State<FlashCard2> with TickerProviderStateMixin {
  String category;
  String filierematiere;
  List<List<String>> allFlashCards;
  final int value=0;

  ScrollController _smoothScrollController;

  _FlashCard2State(category,filierematiere);

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
                    final list =FlipCard(
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
                                  )
                                  ,IconButton(
        icon: Icon(Icons.apps),
        tooltip: 'Affiche l\'ensemble des notions de cette catégories',
        onPressed: () {}
          )
                                            ]),
                                  
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
                                  Text(snapshot.data[index][1],textAlign: TextAlign.center),
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
                                      0.05),

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
                                      
                                      Image.asset("images/Images"+filierematiere+"/"+snapshot.data[index][2],height: 250,width: 300),
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
                                              //StarDisplay(value: 3)
                                              //StarRating(value:0),
                                              StatefulStarRating(),
                                              Row(
                                                mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                                    RaisedButton(
                                                      padding: EdgeInsets.all(10.0),
                                                      child: new Text(
                                                          "Pas vu",
                                                      ),
                                                      onPressed:(){
                                                          moveToNextCard();
                                                      })
                                                    ,
                                                    FlatButton(
                                                      onPressed: () => {moveToNextCard()},

                                                      padding: EdgeInsets.all(10.0),
                                                      child: Row( // Replace with a Row for horizontal icon + text
                                                        children: <Widget>[
                                                          Text("Suivante"),
                                                          Icon(Icons.play_arrow),
                                                          
                                                        ],
                                                      )
                                                      )
                                            ]
                                              )
                                              
                            
                                          // Row(
                                          //   mainAxisAlignment:
                                          //   MainAxisAlignment.center,
                                          //   children: <Widget>[
                                          //     RaisedButton(
                                          //       child: Icon(Icons
                                          //           .sentiment_very_dissatisfied),
                                          //       onPressed: () {
                                          //         _controller.forward(
                                          //             from: _controller
                                          //                 .lowerBound);
                                          //         _controller.animateTo(0.33);
                                          //         moveToNextCard();
                                          //       },
                                          //     ),
                                          //     RaisedButton(
                                          //       child: Icon(
                                          //           Icons.sentiment_neutral),
                                          //       onPressed: () {
                                          //         _controller.forward(
                                          //             from: 0.34);
                                          //         _controller.animateTo(0.66);
                                          //         moveToNextCard();
                                          //       },
                                          //     ),
                                          //     RaisedButton(
                                          //       child: Icon(Icons
                                          //           .sentiment_very_satisfied),
                                          //       onPressed: () {
                                          //         _controller.forward(
                                          //             from: 0.67);
                                          //         _controller.animateTo(1);
                                          //         moveToNextCard();
                                          //       },
                                          //     )
                                          //   ],
                                          // )
                                        ],
                                      )
                                    ],
                                  ),
                            ));
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
    String nameFile="ressources/Flc"+filierematiere+"/"+category;
    Future datas;
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

  // class StarDisplay extends StatelessWidget {
  //   final int value;
  //   const StarDisplay({Key key, this.value = 0})
  //       : assert(value != null),
  //         super(key: key);
  //   @override
  //   Widget build(BuildContext context) {
  //     return Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: List.generate(5, (index) {
  //         return IconTheme(
  //                 data: IconThemeData(
  //                   color: Colors.amber,
  //                   size: 48,
  //                 ),
  //                 child: Icon(
  //                           index < value ? Icons.star : Icons.star_border,
  //                         )
  //                       );
  //                 }),
  //             );
  //   }
  // }

class StarRating extends StatelessWidget {
  final int value;
  final IconData filledStar;
  final IconData unfilledStar;
  final void Function(int index) onChanged;
  const StarRating({
    Key key,
    this.value = 0,
    this.onChanged,
    this.filledStar,
    this.unfilledStar,
  })  : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).accentColor;
    final size = 36.0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: onChanged != null
              ? () {
                  onChanged(value == index + 1 ? index : index + 1);
                }
              : null,
          color: index < value ? color : null,
          iconSize: size,
          icon: Icon(
            index < value 
               ? filledStar ?? Icons.star 
               : unfilledStar ?? Icons.star_border,
          ),
          padding: EdgeInsets.zero,
          tooltip: "${index + 1} of 5",
        );
      }),
    );
  }
}

class StatefulStarRating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int rating = 0;
    return StatefulBuilder(
      builder: (context, setState) {
        return StarRating(
          onChanged: (index) {
            final snackBar = SnackBar(
                        content: Text('Bientôt les résultats seront mémorisés et analysés pour aider à améliorer l\'apprentissage sur ces flashcards'),
                        // action: SnackBarAction(
                        //   label: 'Undo',
                         //  onPressed: () {
                        //     // Some code to undo the change.
                        //  },
            //,
            );
            Scaffold.of(context).showSnackBar(snackBar);
             setState(() {
               rating = index;
             });
          },
          value: rating,
        );
      },
    );
  }
}