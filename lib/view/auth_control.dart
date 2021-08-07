import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_hackaton/view/bottom_bar.dart';
import 'package:supabase_hackaton/view/login.dart';

import 'package:supabase_hackaton/view/story_list_page.dart';

class AuthControlPage extends StatefulWidget {
  @override
  _AuthControlPageState createState() => _AuthControlPageState();
}

class _AuthControlPageState extends State<AuthControlPage> {
  final box = GetStorage();
  void initState() {
    super.initState();
    bool log = isloggedIn();
    if (log == true) {
      Future.delayed(Duration.zero, () {
        //TODO: anasayfaya yolla
        Get.offAll(BottomBar());
      });
    } else {
      Future.delayed(Duration.zero, () {
        Get.offAll(LoginPage());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Text(""),
    ));
  }

  isloggedIn() {
    if (box.read('userId') != null) {
      return true;
      //Get.offAll(SilverAppBarWithTabBarScreen());
    } else {
      return false;
      //Get.offAll(Login1Page());
    }
  }
}
