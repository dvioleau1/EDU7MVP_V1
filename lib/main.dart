import 'dart:io' show Platform;

import 'package:flashcards/Screen_Size_Config.dart';
import 'package:flashcards/screens/Homepage.dart';
import 'package:flashcards/screens/Profilepage.dart';
import 'package:flashcards/screens/Filierepage.dart';
import 'package:flashcards/screens/Exercicepage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Widget currentScreen = Homepage();
int currentTab = 0;

final List screens = [Homepage(), Filierepage(), Exercicepage(), Profilepage()];

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    final themeData = new ThemeData(
      primarySwatch: Colors.lightBlue,
    );

    final cupertinoTheme = new CupertinoThemeData(
      primaryColor: Colors.lightBlue,
    );

    if (Platform.isIOS) {
      return CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home), title: Text("Accueil")),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.book), title: Text("Flashcards")),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.book), title: Text("Exercices")),
             BottomNavigationBarItem(
                 icon: Icon(CupertinoIcons.person), title: Text("Profil"))
            ],
          ),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return Homepage();
                break;
              case 1:
                return Filierepage();
                break;
              case 2:
                return Exercicepage();
                break;
             case 3:
                 return Profilepage();
                 break;
              default:
                return Homepage();
                break;
            }
          }
      );
    }

    return PlatformProvider(
      //initialPlatform: initialPlatform,
      builder: (BuildContext context) =>
          PlatformApp(
              title: 'Edu7',
              android: (_) => new MaterialAppData(theme: themeData),
              ios: (_) => new CupertinoAppData(theme: cupertinoTheme),
              home: PlatformScaffold(
                widgetKey: Key("main"),
                appBar: PlatformAppBar(
                  title: Text("Edu7"),
                ),
                bottomNavBar: PlatformNavBar(
                  android: (_) => MaterialNavBarData(type: BottomNavigationBarType.fixed),
                  currentIndex: currentTab,
                  itemChanged: (i) {
                    setState(() {
                      currentTab = i;
                      currentScreen = screens[i];
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), title: Text("Accueil")),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.book), title: Text("Flc")),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.content_paste), title: Text("Exo")),
                    BottomNavigationBarItem(
                          icon: Icon(Icons.person), title: Text("Profil"))
                  ],
                ),
                body: screens[currentTab],
              )),
    );
  }
}
