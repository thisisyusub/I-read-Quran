import 'package:flutter/material.dart';

import '../../../data/models/surah.dart';

class SurahItemDetailPage extends StatefulWidget {
  const SurahItemDetailPage({Key key, this.surah}) : super(key: key);

  final Surah surah;

  @override
  _SurahItemDetailPageState createState() => _SurahItemDetailPageState();
}

class _SurahItemDetailPageState extends State<SurahItemDetailPage> {
  StringBuffer sb = StringBuffer();

  @override
  void initState() {
    widget.surah.verses.forEach((verse) => sb.write('${verse.text}\n'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text(sb.toString())),
    );
  }
}
