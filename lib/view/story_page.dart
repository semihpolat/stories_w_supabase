import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_hackaton/const/text_styles.dart';

import 'package:supabase_hackaton/controller/story_controller.dart';
import 'package:supabase_hackaton/view/profile_other.dart';
import 'package:supabase_hackaton/view/widgets/text_span.dart';
import 'package:textless/textless.dart';
import 'package:supercharged/supercharged.dart';

class StoryPage extends StatefulWidget {
  final String? title;
  final int? storyId;
  StoryPage({this.title, this.storyId});
  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final myController = TextEditingController();

  final StoryController xController = Get.put(StoryController());

  @override
  void initState() {
    print('storyId ' + widget.storyId!.toString());
    xController.storyId = widget.storyId!;
    xController.getData();
    xController.subscribeToMessages();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = Get.height;
    double w = Get.width;
    return Scaffold(
        body: Container(
      height: Get.height,
      width: Get.width,
      color: Color(0xfff2eecb),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: h * 0.1,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: w * 0.05,
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: h * 0.05,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.title!,
                        style: GoogleFonts.quicksand(
                          textStyle: TextStyles.profileName,
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(() {
                  if (xController.isLoading.value)
                    return Center(child: CircularProgressIndicator());
                  else
                    return Container(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: RichText(
                              text: TextSpan(
                                  text: '',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      backgroundColor: Colors.white),
                                  children: <TextSpan>[
                                for (var item in xController.dataX)
                                  TextSpan(
                                      text: '',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          backgroundColor: Colors.white),
                                      children: <TextSpan>[
                                        storyCek(item.story!,
                                            item.userid.toString()),
                                      ]),
                              ])),
                        ));
                }),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _sendMessageArea(),
            ],
          )
        ],
      ),
    ));
  }

  _sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Color(0xfff2eecb),
      child: Row(
        children: <Widget>[
          /* IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              
            },
          ), */
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              controller: myController,
              decoration: InputDecoration.collapsed(
                hintText: 'Send a story line..',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Colors.black,
            onPressed: () {
              xController.sendMessage(GetStorage().read('userId').toInt(),
                  widget.storyId!.toInt(), myController.text);
              // xController.insertMessage(myController.text);
              myController.clear();
              FocusScope.of(context).unfocus();
            },
          ),
        ],
      ),
    );
  }
}
