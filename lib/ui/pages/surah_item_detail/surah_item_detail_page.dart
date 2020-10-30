import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

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
  var autoScrollController;

  @override
  void initState() {
    super.initState();
    autoScrollController = AutoScrollController(axis: Axis.vertical);

    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (widget.surah.readVerseCount > 0) {
          autoScrollController.scrollToIndex(
            widget.surah.readVerseCount,
            preferPosition: AutoScrollPosition.middle,
          );
        }
      });
    }
  }

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
          controller: autoScrollController,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          itemBuilder: (_, index) {
            final number = widget.surah.verses[index].number;
            final formattedNumber =
                number.contains(',') ? number.split(',').first.trim() : number;

            return AutoScrollTag(
              controller: autoScrollController,
              index: int.parse(formattedNumber),
              key: ValueKey(int.parse(formattedNumber)),
              child: VerseItem(
                verse: widget.surah.verses[index],
                surah: widget.surah,
                refreshCallback: () {
                  setState(() {});
                  widget.refreshCallback?.call();
                },
              ),
            );
          },
          itemCount: widget.surah.verses.length,
        ),
      ),
    );
  }
}
