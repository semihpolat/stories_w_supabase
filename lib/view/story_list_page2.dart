import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injector/injector.dart';

import 'package:supabase/supabase.dart';
import 'package:supabase_hackaton/model/stories_model.dart';
import 'package:supabase_hackaton/view/widgets/stories_scroll_detail.dart';
import 'package:supabase_hackaton/view/widgets/tabs_header.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';

class StoryListPage2 extends StatelessWidget {
  final CategoryDetailsController xController =
      Get.put(CategoryDetailsController());
  final String? title;
  StoryListPage2({this.title});
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Obx(() {
      if (xController.isLoading.value)
        return Scaffold(
            body: Container(
                height: _height,
                width: _width,
                color: Colors.black,
                child: Center(child: CircularProgressIndicator())));
      else
        return Scaffold(
          body: Stack(
            children: [
              TikTokStyleFullPageScroller(
                contentSize: xController.dataX.length,
                swipePositionThreshold: 0.2,
                // ^ the fraction of the screen needed to scroll
                swipeVelocityThreshold: 2000,
                // ^ the velocity threshold for smaller scrolls
                animationDuration: const Duration(milliseconds: 300),
                // ^ how long the animation will take
                builder: (BuildContext context, int index) {
                  return StoriesScrollDetails(
                    quote: xController.dataX[index].name,
                    img: xController.dataX[index].pp,
                    storyId: xController.dataX[index].id,
                  );
                },
              ),
            ],
          ),
        );
    });
  }
}

class CategoryDetailsController extends GetxController {
  final SupabaseClient supabaseClient =
      Injector.appInstance.get<SupabaseClient>();
  final box = GetStorage();
  String categoryName = 'Tarih';
  int conId = 0;
  var isLoading = true.obs;
  late RealtimeSubscription messageSubscription;

  RxList<StoriesModel> xModel = RxList<StoriesModel>();
  List<StoriesModel> get dataX => xModel.value;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    try {
      isLoading(true);
      var xVars = await getDataService();
      if (xVars != null) {
        xVars.shuffle();
        xModel.value = xVars;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<List<StoriesModel>> getDataService() async {
    print('bura calist');
    final response = await supabaseClient.from('stories').select().execute();

    print(response.data.toString());
    if (response.error == null) {
      final results = response.data as List<dynamic>;
      final dataList = response.data as List;
      return dataList.map((map) => StoriesModel.fromJson(map)).toList();
    }
    return [];
  }
}
