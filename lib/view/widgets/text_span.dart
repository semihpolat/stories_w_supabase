import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:supabase_hackaton/controller/story_controller.dart';
import 'package:supabase_hackaton/view/profile_other.dart';

final StoryController xController = Get.put(StoryController());
storyCek(String story, String userId) {
  return TextSpan(
    recognizer: new TapGestureRecognizer()
      ..onTap = () {
        Get.to(ProfileOther(
          userId: userId,
          isMe: false,
        ));
      },
    text: '    ' + story,
    style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        backgroundColor: Color(xController.giveRandomColor()).withOpacity(0.6)),
  );
}
