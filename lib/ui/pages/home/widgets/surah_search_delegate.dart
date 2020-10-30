import 'package:flutter/material.dart';

import '../../../../data/services/hive_service.dart';
import '../../surah_item_detail/surah_item_detail_page.dart';

class SurahSearchDelegate extends SearchDelegate<String> {
  final _allSurah = HiveService().allSurah;

  @override
  String get searchFieldLabel => 'Surəni Axtar';

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        ),
      ];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Theme.of(context).primaryColor,
      appBarTheme: AppBarTheme(
        color: Theme.of(context).primaryColor,
        brightness: Brightness.light,
      ),
      primaryColorBrightness: Brightness.dark,
      textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white),
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: Colors.white)),
    );
  }

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        },
      );

  @override
  Widget buildResults(BuildContext context) => _buildResults(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildResults(context);

  Widget _buildResults(BuildContext context) {
    final resultSurah = _allSurah
        .where(
          (surah) => surah.latin.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();

    return resultSurah.isEmpty
        ? Center(
            child: Text('Belə surə tapılmadı!'),
          )
        : Material(
            child: ListView.builder(
              itemBuilder: (_, index) {
                final currentSurah = resultSurah[index];

                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              SurahItemDetailPage(surah: currentSurah),
                        ),
                      );
                    },
                    title: Text(
                      '${currentSurah.index}. ${currentSurah.latin} surəsi',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    subtitle: Text(
                      '${currentSurah.verseCount} ayə, '
                      '${currentSurah.type}',
                    ),
                  ),
                );
              },
              itemCount: resultSurah.length,
            ),
          );
  }
}
