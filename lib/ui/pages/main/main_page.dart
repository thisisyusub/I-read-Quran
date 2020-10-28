import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../home/home_page.dart';
import '../../values/colors.dart';
import '../bookmarks/bookmarks_page.dart';
import '../diagrams/diagrams_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).primaryColor,
      ),
      child: Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: _currentPageIndex,
            children: [
              HomePage(),
              BookmarksPage(),
              DiagramPage(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.shifting,
          fixedColor: Theme.of(context).primaryColor,
          showUnselectedLabels: true,
          unselectedItemColor: surahDescriptionTextColor,
          currentIndex: _currentPageIndex,
          onTap: (int selectedPageIndex) {
            setState(() {
              _currentPageIndex = selectedPageIndex;
            });
          },
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
