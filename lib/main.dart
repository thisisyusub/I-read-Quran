import 'package:flutter/material.dart';

import './ui/pages/main/main_page.dart';
import './ui/values/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
