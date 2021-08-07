import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_hackaton/const/text_styles.dart';

class OtherProfileHeader extends StatelessWidget {
  final String? headerText;
  final Widget? finalLink;
  final IconData? icon;
  OtherProfileHeader({this.finalLink, this.headerText, this.icon});
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height,
      width: _width,
      child: Column(
        children: [
          SizedBox(
            height: _height * 0.05,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: _height * 0.05,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 8,
                child: Row(
                  children: [
                    Text(
                      headerText!,
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyles.profileHeader,
                      ),
                    ),
                  ],
                ),
              ),
              if (finalLink != null)
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () {
                      Get.to(finalLink);
                    },
                    child: Icon(
                      icon,
                      color: Colors.white.withOpacity(0.7),
                      size: 35,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
