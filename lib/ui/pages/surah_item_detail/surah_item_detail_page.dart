import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../data/models/surah.dart';
import './widgets/verse_item.dart';

class SurahItemDetailPage extends StatefulWidget {
  const SurahItemDetailPage({
    Key key,
    @required this.surah,
    this.refreshCallback,
  }) : super(key: key);

  final Surah surah;
  final VoidCallback refreshCallback;

  @override
  _SurahItemDetailPageState createState() => _SurahItemDetailPageState();
}

class _SurahItemDetailPageState extends State<SurahItemDetailPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0xFFa78462),
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Color(0xFFcbb39e),
        body: ListView.builder(
          physics: ClampingScrollPhysics(),
          itemBuilder: (_, index) => VerseItem(
            verse: widget.surah.verses[index],
            surah: widget.surah,
            refreshCallback: () {
              setState(() {});
              widget.refreshCallback?.call();
            },
          ),
          itemCount: widget.surah.verses.length,
        ),
      ),
    );
  }
}
