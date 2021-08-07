import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injector/injector.dart';
import 'package:ionicons/ionicons.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_hackaton/const/text_styles.dart';
import 'package:supabase_hackaton/model/user_model.dart';
import 'package:supabase_hackaton/view/login.dart';
import 'package:supabase_hackaton/view/widgets/other_profile_header.dart';

class ProfileOther extends StatefulWidget {
  final bool? isMe;
  final String? userId;
  ProfileOther({this.userId, this.isMe});

  @override
  _ProfileOtherState createState() => _ProfileOtherState();
}

class _ProfileOtherState extends State<ProfileOther> {
  final OtherProfileController xController = Get.put(OtherProfileController());
  @override
  void initState() {
    xController.userId = widget.userId!;
    xController.getData();
    // TODO: implement initState
    super.initState();
  }

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
          backgroundColor: Colors.grey.shade300,
          body: Container(
            height: _height,
            color: Colors.grey,
            child: SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: [
                      SizedBox(
                        height: _height * 0.6,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(xController.dataX[0].pp!),
                                  // "https://data.whicdn.com/images/273880215/original.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Container(
                        height: _height * 0.4,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xfff2eecb),
                              Color(0xffffffff),
                              // Color(0xff9d55e8),
                            ],
                          ),
                          // color: Colors.red,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xfff2eecb),
                              spreadRadius: 80,
                              blurRadius: 50,
                              offset:
                                  Offset(30, 0), // changes position of shadow
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: _width * 0.05, top: _height * 0.58),
                    //height: _height * 0.1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          xController.dataX[0].username!,
                          style: GoogleFonts.quicksand(
                            textStyle: TextStyles.profileName,
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.02,
                        ),
                        Text(
                          xController.dataX[0].bio!,
                          style: GoogleFonts.quicksand(
                            textStyle: TextStyles.profileBio,
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.1,
                        ),
                      ],
                    ),
                  ),
                  if (widget.isMe == false)
                    OtherProfileHeader(
                      headerText: '',
                    ),
                  if (widget.isMe == true)
                    Column(
                      children: [
                        SizedBox(
                          height: _height * 0.05,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: _width * 0.85,
                            ),
                            InkWell(
                              onTap: () {
                                GetStorage().remove('userId');
                                GetStorage().remove('userToken');
                                if (GetStorage().read('userId') == null) {
                                  print('user data silindi');
                                }
                                Get.offAll(LoginPage());
                              },
                              child: Icon(
                                Icons.logout,
                                size: _height * 0.05,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        );
    });
  }
}

class OtherProfileController extends GetxController {
  final SupabaseClient supabaseClient =
      Injector.appInstance.get<SupabaseClient>();
  final box = GetStorage();
  String userId = '';
  int conId = 0;
  var isLoading = true.obs;
  late RealtimeSubscription messageSubscription;

  RxList<UserModel> xModel = RxList<UserModel>();
  List<UserModel> get dataX => xModel.value;

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

  Future<List<UserModel>> getDataService() async {
    print('bura calist');
    final response =
        await supabaseClient.from('users').select().eq('id', userId).execute();

    print(response.data.toString());
    if (response.error == null) {
      final results = response.data as List<dynamic>;
      final dataList = response.data as List;
      return dataList.map((map) => UserModel.fromJson(map)).toList();
    }
    return [];
  }
}
