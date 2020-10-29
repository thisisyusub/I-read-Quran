import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../data/models/surah.dart';
import '../../../../data/models/verse.dart';
import '../../../../data/services/hive_service.dart';

class VerseItem extends StatelessWidget {
  const VerseItem({
    Key key,
    @required this.verse,
    @required this.surah,
    this.refreshCallback,
  }) : super(key: key);

  final Verse verse;
  final Surah surah;
  final VoidCallback refreshCallback;

  @override
  Widget build(BuildContext context) {
    final number = verse.number.contains(',')
        ? verse.number.split(',').last.trim()
        : verse.number;
    final completed = surah.readVerseCount == int.tryParse(number);

    return GestureDetector(
      onDoubleTap: () async {
        var message;
        bool success;

        try {
          final result = await HiveService()
              .addToBookmark(surah.index, surah.latin, verse);

          if (result) {
            message = 'Seçilmişlərə uğurla əlavə edildi.';
          } else {
            message = 'Artıq əlavə olunub!';
          }
          success = true;
        } on Exception {
          message = 'Xəta baş verdi, yenidən yoxlayın!';
          success = false;
        }

        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
              backgroundColor: success ? Colors.green : Colors.red,
              content: Text(message)));
      },
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.20,
        closeOnScroll: true,
        secondaryActions: [
          IconSlideAction(
            icon: completed ? Icons.remove_done : Icons.done,
            color: Theme.of(context).primaryColor,
            onTap: () async {
              await HiveService()
                  .changeProgress(completed ? '0' : verse.number, surah.index);
              refreshCallback?.call();
            },
          ),
        ],
        child: Container(
          color: completed ? Theme.of(context).primaryColor : null,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: RichText(
            text: TextSpan(
              text: '${verse.number}. ',
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: completed ? Colors.white : Colors.black,
                  ),
              children: [
                TextSpan(
                  text: verse.translation,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
