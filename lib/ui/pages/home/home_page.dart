import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_read_quran/data/services/surah_parser_service.dart';
import 'package:i_read_quran/ui/pages/surah_item_detail/surah_item_detail_page.dart';

import './widgets/home_page_top_painter.dart';
import './widgets/surah_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomPaint(
          painter: HomePageTopPainter(),
          child: Container(
            width: double.infinity,
            height: 130,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    color: Theme.of(context).primaryColor,
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.search),
                      onPressed: () {},
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/mosque.svg',
                        height: 70,
                        width: 70,
                      ),
                      const SizedBox(width: 20),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            height: 2,
                            fontSize: 18,
                          ),
                          text: 'Mən Quran oxuyuram\n',
                          children: [
                            TextSpan(
                              text: '#MənQuranOxuyuram',
                              style: TextStyle(
                                height: 2,
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Material(
                    color: Theme.of(context).primaryColor,
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        print('working');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
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
                          description:
                              '${currentSurah.surahDescription}, ${currentSurah.ayahCount} ayədir.',
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
