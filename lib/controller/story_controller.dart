import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injector/injector.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_hackaton/model/story_lines_model.dart';

import 'package:supabase_hackaton/model/story_model.dart';

class StoryController extends GetxController {
  final SupabaseClient supabaseClient =
      Injector.appInstance.get<SupabaseClient>();
  var isLoading = true.obs;
  final box = GetStorage();
  String userId = '';
  int storyId = 0;
  RxList<StoryLinesModel> xModel = RxList<StoryLinesModel>();
  List<StoryLinesModel> get dataX => xModel.value;
  late RealtimeSubscription messageSubscription;

  List randomColor = [
    'B28CFF',
    'C6A3FF',
    'D9AAFB',
    'FFABAB',
    'FFCBC0',
    'D8FFD3',
    'B6B9FF',
    'D9FFD4',
    'FFF4BA',
    'A7C4A0',
    '8F8389',
    'C5F4E0',
    'E6EFE9',
    '393e46',
    'aad8d3'
  ];

  @override
  void onInit() {
    userId = box.read('userId').toString();
    print(userId.toString());

    super.onInit();
  }
  /*  void onInit() {
    fetchAPI();
    super.onInit();
  } */

  int giveRandomColor() {
    final _random = new Random();
    var element = randomColor[_random.nextInt(randomColor.length)];
    return int.parse('0xff' + element);
  }

  void getData() async {
    try {
      isLoading(true);
      var xVars = await getDataService();
      if (xVars != null) {
        xModel.value = xVars;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<List<StoryLinesModel>> getDataService() async {
    print('bura calist');
    final response = await supabaseClient
        .from('story_lines')
        .select()
        .eq('storyid', storyId.toString())
        .execute();

    print(response.data.toString());
    if (response.error == null) {
      final results = response.data as List<dynamic>;
      final dataList = response.data as List;
      return dataList.map((map) => StoryLinesModel.fromJson(map)).toList();
    }
    return [];
  }

  subscribeToMessages() {
    messageSubscription = supabaseClient
        .from('story_lines')
        .on(SupabaseEventTypes.insert, (payload) {
      print(payload.newRecord.toString());
      if (payload.newRecord['storyid'] == dataX[0].storyid) {
        StoryLinesModel x = StoryLinesModel(
          id: payload.newRecord['id'],
          storyid: payload.newRecord['storyid'],
          userid: payload.newRecord['userid'],
          story: payload.newRecord['story'],
        );
        insertMessage(x); //burdan ekliyor

      }
    }).subscribe();
  }

  RemoveSubscriptionRealtime() {
    supabaseClient.removeSubscription(messageSubscription);
  }

  void sendMessage(int senderId, int storyid, String message) async {
    print(senderId.toString());
    print(storyid.toString());
    print(message.toString());
    await supabaseClient
        .from('story_lines')
        .insert({'userid': senderId, 'storyid': storyid, 'story': message})
        .execute()
        .then((value) {
          /*   ChatModel x = ChatModel(
              idChat: dataX[dataX.length - 1].idChat! + 1,
              conId: conId,
              senderId: senderId,
              message: message,
              createdAt: DateTime.now().toString());
          insertMessage(x); */
        });
  }

  void insertMessage(StoryLinesModel a) {
    xModel.value.insert(xModel.length, a);

    xModel.refresh();
    print('a' + a.toString());
  }
  /* void fetchAPI() async {
    try {
      isLoading(true);
      String response = await rootBundle.loadString('assets/stories.json');
      //print('response.body : ' + response.toString());
      var jsonString = response;
      //print('response.body : ' + response.toString());
      var xVars = StoryModel.fromJson(json.decode(jsonString));
      if (xVars != null) {
        //ters cevirici
        // xModel.value.response.reversed.toList();
        xModel.value = xVars;
      }
    } finally {
      isLoading(false);
    }
  }

  void insertMessage(String b) {
    StoryLines a = StoryLines(story: b);
    xModel.value.storyLines!.insert(xModel.value.storyLines!.length, a);

    xModel.refresh();
    print('a' + a.toString());
  } */
}
