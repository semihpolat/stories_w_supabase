import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:supabase_hackaton/view/story_page.dart';

class StoryBox extends StatelessWidget {
  final String? title;
  final String? ss;
  const StoryBox({Key? key, this.title, this.ss}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: _height * 0.05,
        ),
        InkWell(
          onTap: () {
            Get.to(StoryPage(
              title: title,
            ));
          },
          child: Container(
            width: _width * 0.95,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      child: Image.network(
                        ss!,
                      ),
                    ),
                    Text(
                      title!,
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
