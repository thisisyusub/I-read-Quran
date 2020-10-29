import 'package:flutter/material.dart';
import 'file:///Z:/My%20Projects/i_read_quran/tools/surah_parser_service.dart';

import './ui/pages/main/main_page.dart';
import './ui/values/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SurahParserService().fetchAllSurah();

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
