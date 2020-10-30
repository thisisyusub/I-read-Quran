import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './data/models/surah.dart';
import './data/models/verse.dart';
import './data/services/hive_service.dart';
import './ui/pages/main/main_page.dart';
import './ui/values/theme.dart';
import './ui/widgets/custom_scroll_behaviour.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(SurahAdapter());
  Hive.registerAdapter(VerseAdapter());

  await Hive.openBox('appBox');
  await HiveService().configDatabase(version: 1);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mən Quran oxuyuram',
      theme: lightTheme,
      debugShowCheckedModeBanner: !kDebugMode,
      locale: Locale('aze', 'AZ'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (_, child) {
        return ScrollConfiguration(
          behavior: CustomScrollBehaviour(),
          child: child,
        );
      },
      home: MainPage(),
    );
  }
}
