import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/entitys/channels.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/common/values/values.dart';

// 频道
Widget newsChannels(
    {required List<NewsChannelsDatum> channels,
    required Function(NewsChannelsDatum) onTap}) {
  // ignore: sized_box_for_whitespace
  return Container(
    height: duSetHeight(137),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: channels.map<Widget>((e) {
          return Container(
              width: duSetWidth(70),
              height: duSetHeight(97),
              margin: EdgeInsets.symmetric(horizontal: duSetWidth(10)),
              child: InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //图标
                    Container(
                      height: duSetWidth(64),
                      margin: EdgeInsets.symmetric(horizontal: duSetWidth(3)),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            child: Container(
                              height: duSetWidth(64),
                              decoration: const BoxDecoration(
                                color: AppColors.primaryBackground,
                                boxShadow: [
                                  Shadows.primaryShadow,
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32)),
                              ),
                              child: Container(),
                            ),
                          ),
                          Positioned(
                              left: duSetWidth(10),
                              right: duSetWidth(10),
                              top: duSetWidth(10),
                              child: Image.asset(
                                  "assets/images/channel-${e.code}.png"))
                        ],
                      ),
                    ),
                    // 标题
                    Text(
                      e.title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: TextStyle(
                        color: AppColors.thirdElementText,
                        fontFamily: "Avenir",
                        fontWeight: FontWeight.w400,
                        fontSize: duSetFontSize(14),
                        height: 1,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  onTap(e);
                },
              ));
        }).toList(),
      ),
    ),
  );
}
