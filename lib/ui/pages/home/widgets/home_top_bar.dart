import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import './home_page_top_painter.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return CustomPaint(
      painter: HomePageTopPainter(),
      child: Container(
        width: double.infinity,
        height: size.height * 0.2,
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
                    height: size.height * 0.1,
                  ),
                  const SizedBox(width: 20),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '#MənQuranOxuyuram',
                      style: TextStyle(
                        height: 2,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
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
    );
  }
}
