import 'package:flutter/material.dart';

import '../../../values/colors.dart';
import '../../../../data/models/surah.dart';

class SurahItem extends StatelessWidget {
  const SurahItem({Key key, @required this.surah}) : super(key: key);

  final Surah surah;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          width: 1,
          color: surahItemBorderColor,
        ),
      ),
      child: Column(
        children: [
          Text(
            '${surah.index}. ${surah.latin} surəsi',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            '${surah.type}, ${surah.verseCount} ayədir.',
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: surahDescriptionTextColor,
                ),
            textAlign: TextAlign.center,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Stack(
              children: [
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: progressBarBackgroundColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: surah.readVerseCount / surah.verseCount,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: surah.readVerseCount == surah.verseCount
                          ? Colors.green
                          : progressBarColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${surah.readVerseCount}/${surah.verseCount}',
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: surahDescriptionTextColor,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
          ),
        ],
      ),
    );
  }
}
