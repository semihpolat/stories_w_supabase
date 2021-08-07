import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = Get.height;
    double w = Get.width;
    return Scaffold(
      body: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://i.pinimg.com/originals/5f/67/5d/5f675de67cba9ce24c6c26b9fccbe03c.gif'),
                fit: BoxFit.cover)),
      ),
    );
  }
}
