import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:supabase_hackaton/const/text_styles.dart';
import 'package:supabase_hackaton/view/story_page.dart';

class StoriesScrollDetails extends StatelessWidget {
  String? quote;
  int? storyId;
  String? img;
  StoriesScrollDetails({this.quote, this.img, this.storyId});
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(img!), fit: BoxFit.cover)),
      height: _height,
      width: _width,
      //  color: Colors.black,
      child: Column(
        children: [
          SizedBox(
            height: _height * 0.48,
          ),
          InkWell(
            onTap: () {
              Get.to(StoryPage(
                title: quote,
                storyId: storyId,
              ));
            },
            child: Container(
              width: _width,
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Text(
                  quote!,
                  style: TextStyles.homeQuote,
                ),
              ),
            ),
          ),
          SizedBox(
            height: _height * 0.1,
          ),
        ],
      ),
    );
  }
}
