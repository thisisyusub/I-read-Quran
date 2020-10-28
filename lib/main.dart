import 'package:flutter/material.dart';

import './ui/values/theme.dart';
import './ui/pages/main/main_page.dart';

import './data/services/surah_parser_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final allSurah = await SurahParserService().fetchAllSurah();
  SurahParserService().allSurah = allSurah;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mən Quran oxuyuram',
      theme: lightTheme,
      home: MainPage(),
    );
  }
}
