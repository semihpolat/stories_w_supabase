import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:supabase_hackaton/view/widgets/story_box.dart';

class StoryListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = Get.height;
    double w = Get.width;
    return Scaffold(
      body: Container(
        height: h,
        width: w,
        child: SingleChildScrollView(
          child: Column(
            children: [
              StoryBox(
                title: 'sinbad',
                ss: 'https://tucuentofavorito.com/wp-content/uploads/2019/04/simbad-ingles.jpg',
              ),
              StoryBox(
                title: 'İstanbulda bir gece',
                ss: 'https://www.emlakrotasi.com.tr/wp-content/uploads/2017/06/beyoglu-sokaklari-yenileniyor.jpg',
              ),
              StoryBox(
                title: 'yıl 2900',
                ss: 'https://i.pinimg.com/736x/44/82/a9/4482a93fcb0224e37983741d85130faf.jpg',
              ),
              StoryBox(
                title: 'sinbad',
                ss: 'https://tucuentofavorito.com/wp-content/uploads/2019/04/simbad-ingles.jpg',
              ),
              StoryBox(
                title: 'İstanbulda bir gece',
                ss: 'https://www.emlakrotasi.com.tr/wp-content/uploads/2017/06/beyoglu-sokaklari-yenileniyor.jpg',
              ),
              StoryBox(
                title: 'yıl 2900',
                ss: 'https://i.pinimg.com/736x/44/82/a9/4482a93fcb0224e37983741d85130faf.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
