import 'package:flutter/material.dart';
import 'package:i_read_quran/data/services/surah_parser_service.dart';

import './widgets/home_top_bar.dart';
import './widgets/surah_item.dart';
import '../surah_item_detail/surah_item_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeTopBar(),
        const SizedBox(height: 20),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8.0,
                ),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 1 / 1.3,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (_, i) {
                      final currentSurah = SurahParserService().allSurah[i];

                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SurahItemDetailPage(
                              surah: currentSurah,
                            ),
                          ),
                        ),
                        child: SurahItem(
                          name: '${currentSurah.surahNumber}. '
                              '${currentSurah.surahName} surəsi',
                          description: '${currentSurah.surahDescription}.',
                          readCount: 0,
                          verseCount: currentSurah.ayahCount,
                        ),
                      );
                    },
                    childCount: SurahParserService().allSurah.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
