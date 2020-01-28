import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class RevisionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RevisionPageState();
  }
}

class _RevisionPageState extends State<RevisionPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding( padding: const EdgeInsets.all(16.0), child: Text("A venir. Espace d'entraide."),)
    );


  }
}
