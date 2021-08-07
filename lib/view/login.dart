import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injector/injector.dart';

import 'package:supabase/supabase.dart';
import 'package:supabase_hackaton/view/bottom_bar.dart';
import 'package:supabase_hackaton/view/story_list_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: _height,
          width: _width,
          decoration: BoxDecoration(color: Color(0xff152B35)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: _height * 0.3,
                ),
                SizedBox(
                  height: _height * 0.05,
                ),
                Container(
                  height: _height * 0.06,
                  width: _width * 0.9,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      /*  validator: validation,
              controller: controller,
              onChanged: onTap, */
                      controller: usernameController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: 'Mail Adresi'),
                    ),
                  )),
                  //  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                ),
                SizedBox(
                  height: _height * 0.02,
                ),
                Container(
                  height: _height * 0.06,
                  width: _width * 0.9,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      /*  validator: validation,
              controller: controller,
              onChanged: onTap, */
                      controller: passwordController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: 'Şifre'),
                    ),
                  )),
                  //  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 60, right: 60, top: 30),
                        child: Container(
                          height: 50,
                          child: OutlineButton(
                              color: Colors.white,
                              child: Text("Giriş Yap",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                /* print(GetStorage().read('userId').toString());
                            GetStorage().write('onBoarding', 0); */
                                /*  print("User Type = " + _value);
                            print("Mail Adres = " + email!);
                            print("Password = " + password!);
                            login(email, password); */
                                if (usernameController.text.toString() ==
                                        'null' ||
                                    passwordController.text.toString() ==
                                        'null') {
                                } else {
                                  login(usernameController.text,
                                      passwordController.text);
                                }
                              },
                              borderSide:
                                  BorderSide(color: Colors.white, width: 3),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  void login(email, password) async {
    print(email);
    print(password);

    await Injector.appInstance
        .get<SupabaseClient>()
        .from('users')
        .select()
        .eq('username', email)
        .eq('password', password)
        .execute()
        .then((value) {
      print(value.data);

      if (value.data.length > 0) {
        print('giris yapildi');
        GetStorage().write('userId', value.data[0]['id']);
        print('userId : ' + GetStorage().read('userId').toString());
        Get.offAll(BottomBar());
      } else {
        print('giris yapilamadi');
        Get.snackbar("Birşeyler hatalı :(", "Bilgilerini Kontrol Et!",
            backgroundColor: Colors.white, colorText: Colors.black);
      }
    });
    //Get.offAll(BottomBar());
  }
}
