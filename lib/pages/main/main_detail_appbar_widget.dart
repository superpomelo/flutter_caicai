import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/common/values/values.dart';
import 'package:flutter_caicai/common/widgets/widgets.dart';
import 'package:get/get.dart';

///首页详情页导航条
AppBar newAppbar(
    {required BuildContext context,
    Widget? title,
    Widget? leading,
    List<Widget>? actions,
    Color color = Colors.transparent}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: color,
    elevation: 0,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: duSetWidth(0)),
          width: duSetWidth(25),
          height: duSetHeight(25),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: duSetWidth(20)),
          height: duSetHeight(35),
          width: duSetHeight(35),
          child: const CircleAvatar(
            backgroundImage:
                NetworkImage("https://www.itying.com/images/flutter/1.png"),
          ),
        ),
        Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: duSetWidth(10)),
                child: Text(
                  "皮蛋瘦肉粥",
                  style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: duSetFontSize(12),
                      color: AppColors.thirdElementText,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: duSetHeight(5)),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: duSetWidth(10)),
                      child: const Icon(
                        Icons.room,
                        size: 12.0,
                      ),
                    ),
                    Container(
                      child: Text(
                        "火炬大街",
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: duSetFontSize(12),
                            color: AppColors.thirdElementText,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
