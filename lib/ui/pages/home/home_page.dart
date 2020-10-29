import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './widgets/home_top_bar.dart';
import './widgets/surah_item.dart';
import '../../../data/services/hive_service.dart';
import '../surah_item_detail/surah_item_detail_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  final allSurah = HiveService().allSurah;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeTopBar(),
        const SizedBox(height: 20),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ValueListenableBuilder(
                valueListenable:
                    Hive.box('appBox').listenable(keys: ['surahs']),
                builder: (context, value, child) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 1 / 1.1,
                    ),
                    itemBuilder: (_, index) => GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              SurahItemDetailPage(surah: allSurah[index]),
                        ),
                      ),
                      child: SurahItem(surah: allSurah[index]),
                    ),
                    itemCount: allSurah.length,
                  );
                }),
          ),
        ),
      ],
    );
  }
}
