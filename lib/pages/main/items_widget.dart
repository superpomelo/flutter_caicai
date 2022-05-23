import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/entitys/news.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/common/values/values.dart';

Widget newsItem({required Item item, required Function(Item) onTap}) {
  return InkWell(
      onTap: () {
        onTap(item);
      },
      child: Container(
        height: duSetHeight(160),
        padding: EdgeInsets.all(duSetWidth(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ignore: sized_box_for_whitespace
            Container(
              width: duSetWidth(121),
              height: duSetWidth(121),
              child: Image.asset(
                "assets/images/feature-${item.id}.png",
                fit: BoxFit.fill,
              ),
            ),
            // ignore: sized_box_for_whitespace
            Container(
              width: duSetWidth(194),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(duSetHeight(0)),
                    child: Text(
                      item.category,
                      style: TextStyle(
                          fontFamily: 'Avenir',
                          fontSize: duSetFontSize(14),
                          color: AppColors.thirdElementText,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: duSetHeight(10)),
                    child: Text(
                      item.title,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: duSetFontSize(16),
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w500,
                          height: 1),
                      maxLines: 3,
                    ),
                  ),
                  const Spacer(),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Row(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: duSetWidth(60),
                          ),
                          child: Text(
                            item.author,
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontWeight: FontWeight.normal,
                              color: AppColors.secondaryElementText,
                              fontSize: duSetFontSize(14),
                              height: 1,
                            ),
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                        ),
                        Container(
                          width: duSetWidth(15),
                        ),
                        //时间
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 100),
                          child: Text(
                            item.addtime,
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontWeight: FontWeight.normal,
                              color: AppColors.thirdElementText,
                              fontSize: duSetFontSize(14),
                              height: 1,
                            ),
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                        ),
                        const Spacer(),
                        const InkWell(
                          child: Icon(
                            Icons.more_horiz,
                            color: AppColors.primaryText,
                            size: 24,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ));
}
