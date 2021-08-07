import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_hackaton/view/logout_page.dart';
import 'package:supabase_hackaton/view/profile_other.dart';
import 'package:supabase_hackaton/view/story_list_page2.dart';
import 'package:supabase_hackaton/view/widgets/stories_scroll_detail.dart';

class BottomBar extends StatefulWidget {
  static final String path = "lib/src/pages/animations/anim4.dart";
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int? _currentPage;

  @override
  void initState() {
    _currentPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getPage(_currentPage!),
      bottomNavigationBar: AnimatedBottomNav(
          currentIndex: _currentPage!,
          onChange: (index) {
            setState(() {
              _currentPage = index;
            });
          }),
    );
  }

  getPage(int page) {
    switch (page) {
      case 0:
        return StoryListPage2();
      case 1:
        //   return ConversationHomeScreen();
        return ProfileOther(
          userId: GetStorage().read('userId').toString(),
          isMe: true,
        );
      /*  case 2:
        return LogoutPage(); */
    }
  }
}

class AnimatedBottomNav extends StatelessWidget {
  final int? currentIndex;
  final Function(int)? onChange;
  const AnimatedBottomNav({Key? key, this.currentIndex, this.onChange})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      //TODO: alt menu rengi
      /* decoration: BoxDecoration(
        color: Color(0xffffffff),
      ), */
      decoration: BoxDecoration(
        color: Color(0xfff2eecb),
        boxShadow: [
          BoxShadow(
            color: Color(0xfff2eecb),
            spreadRadius: 20,
            blurRadius: 20,
            offset: Offset(0, 0), // changes position of shadow
          ),
          /*  BoxShadow(
            color: Color(0xffffffff),
            spreadRadius: 20,
            blurRadius: 20,
            offset: Offset(0, 0), // changes position of shadow
          ), */
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => onChange!(0),
              child: BottomNavItem(
                icon: Icons.book,
                title: "Stories",
                isActive: currentIndex == 0,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange!(1),
              child: BottomNavItem(
                icon: Icons.perm_identity,
                title: "Profile",
                isActive: currentIndex == 1,
              ),
            ),
          ),
          /*   Expanded(
            child: InkWell(
              onTap: () => onChange!(2),
              child: BottomNavItem(
                icon: Icons.settings,
                title: "Settings",
                isActive: currentIndex == 2,
              ),
            ),
          ), */
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final bool? isActive;
  final IconData? icon;
  final Color? activeColor;
  final Color? inactiveColor;
  final String? title;
  const BottomNavItem(
      {Key? key,
      this.isActive = false,
      this.icon,
      this.activeColor,
      this.inactiveColor,
      this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      duration: Duration(milliseconds: 500),
      reverseDuration: Duration(milliseconds: 200),
      child: isActive!
          ? Container(
              //color: Colors.black54,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffffffff),
                    spreadRadius: 1,
                    blurRadius: 30,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,

                      //color: activeColor ?? Theme.of(context).primaryColor,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Container(
                    width: 5.0,
                    height: 5.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )
          : Icon(
              icon,
              color: inactiveColor ?? Colors.black,
            ),
    );
  }
}
