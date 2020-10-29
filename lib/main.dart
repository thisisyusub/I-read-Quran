import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './data/models/surah.dart';
import './data/models/verse.dart';
import './data/services/hive_service.dart';
import './ui/pages/main/main_page.dart';
import './ui/values/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(SurahAdapter());
  Hive.registerAdapter(VerseAdapter());

  await Hive.openBox('appBox');
  HiveService().configDatabase(version: 1);

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
