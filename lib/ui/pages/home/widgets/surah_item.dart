import 'package:flutter/material.dart';

import '../../../values/colors.dart';

class SurahItem extends StatelessWidget {
  const SurahItem({
    Key key,
    this.name,
    this.description,
    this.verseCount,
    this.readCount,
  }) : super(key: key);

  final String name;
  final String description;
  final int verseCount;
  final int readCount;

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
          color: readCount == verseCount ? Colors.green : surahItemBorderColor,
        ),
      ),
      child: Column(
        children: [
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: surahDescriptionTextColor,
              fontStyle: FontStyle.italic,
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
                  widthFactor: readCount / verseCount,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: readCount == verseCount
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
            '$readCount/$verseCount',
            style: TextStyle(
              fontSize: 12,
              color: surahDescriptionTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
