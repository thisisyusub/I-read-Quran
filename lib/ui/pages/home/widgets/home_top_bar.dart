import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import './home_page_top_painter.dart';
import './surah_search_delegate.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return CustomPaint(
      painter: HomePageTopPainter(),
      child: Container(
        width: double.infinity,
        height: size.height * 0.16,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Material(
                color: Theme.of(context).primaryColor,
                child: IconButton(
                  color: Colors.white,
                  icon: Icon(CupertinoIcons.search_circle_fill),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: SurahSearchDelegate(),
                    );
                  },
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
                    height: size.height * 0.1,
                  ),
                  const SizedBox(width: 20),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Rəhman və Rəhim olan\nAllahın adı ilə!',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Material(
                    color: Theme.of(context).primaryColor,
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(CupertinoIcons.question_circle_fill),
                      onPressed: () {
                        showDialog(
                          context: context,
                          child: Dialog(
                            child: LimitedBox(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text('Təlimat',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                      const SizedBox(height: 10),
                                      RichText(
                                        textAlign: TextAlign.justify,
                                        text: TextSpan(
                                          text: '1. Surələrə daxil olduqdan '
                                              'sonra ayənin üzərinə 2 dəfə '
                                              'ardıcıl toxunaraq, Seçilmişlərə '
                                              'əlavə edə bilərsiniz.\n',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                          children: [
                                            TextSpan(
                                              text:
                                                  '2. Ayələri sola sürükləyib '
                                                  'görünən düyməyə basaraq, '
                                                  'son oxuduğunuz yeri işarə '
                                                  'edə bilərsiniz.\n',
                                            ),
                                            TextSpan(
                                              text:
                                                  '3. Son oxuduğunuz yeri dəyiş'
                                                  'dirdikdə, avtomatik olaraq,'
                                                  'digər işarə silinir '
                                                  '(əgər varsa).\n',
                                            ),
                                            TextSpan(
                                              text:
                                                  '4. Seçilmişlərə əlavə olunmuş '
                                                  'elementi sağa sürüklədikdə, '
                                                  'görünən düymə vasitəsilə '
                                                  'silə bilərsiniz.\n',
                                            ),
                                            TextSpan(
                                              text: '5. Əgər bir surəni tam '
                                                  'bitirməmisinizsə və son '
                                                  'qaldığınız yeri işarə '
                                                  'etmisinizsə, növbəti dəfə '
                                                  'qayıtdıqda, avtomatik '
                                                  'olaraq, həmin ayəyə gedəcək\n',
                                            ),
                                            TextSpan(
                                              text: 'Diaqramlar səhifəsində '
                                                  'cari zamandək, oxuduğunuz '
                                                  'ayə və surələrin sayı əks '
                                                  'olunacaq. Sıfırla düyməsini '
                                                  'basaraq, oxuduqlarınızı '
                                                  'sıfırlaya bilərsiniz\n',
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        width: double.infinity,
                                        child: RaisedButton(
                                          color: Theme.of(context).primaryColor,
                                          onPressed: Navigator.of(context).pop,
                                          child: Text(
                                            'Təlimatla tanış oldum.',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .copyWith(
                                                  color: Colors.white,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Material(
                    color: Theme.of(context).primaryColor,
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(CupertinoIcons.info_circle_fill),
                      onPressed: () {
                        showAboutDialog(
                          context: context,
                          applicationName: 'Mən Quran Oxuyuram',
                          applicationVersion: 'v0.0.6',
                          children: [
                            Text('Tətbiq Kənan Yusubov tərəfindən hazırlanıb.'),
                          ],
                          applicationLegalese:
                              'Icon made by Freepik from www.flaticon.com\n',
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
