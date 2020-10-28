import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_read_quran/ui/values/colors.dart';

import 'widgets/home_page_top_painter.dart';
import 'widgets/surah_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).primaryColor,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Column(
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
                        child: IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.search),
                          onPressed: () {},
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
                        child: IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.settings),
                          onPressed: () {},
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
                          (_, i) => SurahItem(
                            name: '$i. Surah name',
                            description: 'Surah description',
                            readCount: i % 10,
                            verseCount: 10,
                          ),
                          childCount: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          fixedColor: Theme.of(context).primaryColor,
          showUnselectedLabels: true,
          unselectedItemColor: surahDescriptionTextColor,
          currentIndex: 0,
          items: [
            BottomNavigationBarItem(
              label: 'Quran',
              icon: Icon(Icons.menu_book),
            ),
            BottomNavigationBarItem(
              label: 'Seçilmişlər',
              icon: Icon(Icons.bookmarks),
            ),
            BottomNavigationBarItem(
              label: 'Diaqramlar',
              icon: Icon(Icons.dashboard),
            ),
          ],
        ),
      ),
    );
  }
}
