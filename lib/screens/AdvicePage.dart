import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class AdvicePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdvicePageState();
  }
}

class _AdvicePageState extends State<AdvicePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding( padding: const EdgeInsets.all(16.0), child: Text("A venir. Conseils personnalisés pour mieux apprendre son cours."),)
    );
  }
}
