import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../data/services/hive_service.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('appBox').listenable(keys: ['bookmarks']),
      builder: (_, __, ___) {
        final bookmarks = HiveService().bookmarks;

        if (bookmarks == null || bookmarks.isEmpty) {
          return Center(
            child: Text('Seçilmiş əlavə edilməyib.'),
          );
        }

        return ListView.builder(
          itemBuilder: (_, index) {
            final currentBookmark = bookmarks[index];

            return Card(
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                actions: [
                  IconSlideAction(
                    icon: Icons.delete,
                    color: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    onTap: () =>
                        HiveService().deleteBookmark(currentBookmark).then(
                              (_) => Scaffold.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(content: Text('Uğurla silindi.')),
                                ),
                            ),
                  ),
                ],
                child: ListTile(
                  title: Text(
                    currentBookmark.translation,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  subtitle: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${currentBookmark.surahName} surəsi, '
                      '${currentBookmark.number}-'
                      '${_getSuffix(currentBookmark.number)} ayə',
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: bookmarks.length,
        );
      },
    );
  }

  String _getSuffix(String number) {
    final lastDigitAsString = number[number.length - 1];
    final lastDigit = int.tryParse(lastDigitAsString);

    switch (lastDigit) {
      case 1:
      case 2:
      case 5:
      case 7:
      case 8:
        return 'ci';
      case 3:
      case 4:
      case 0:
        return 'cü';
      case 6:
        return 'cı';
      case 9:
        return 'cu';
      default:
        return null;
    }
  }
}
