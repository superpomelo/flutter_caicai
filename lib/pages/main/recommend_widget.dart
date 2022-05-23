import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/entitys/news.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/common/values/values.dart';

/// 推荐阅读
Widget newsRecommendWidget(
    {required NewsRecommendResponseEntity newsRecommendData,
    required Function(NewsRecommendResponseEntity) onTap}) {
  return Container(
    // height: duSetHeight(490),
    margin: EdgeInsets.all(duSetWidth(20)),
    // color: Colors.amber,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //图
        InkWell(
          onTap: () {
            onTap(newsRecommendData);
          },
          // ignore: sized_box_for_whitespace
          child: Container(
            width: duSetWidth(335),
            height: duSetHeight(290),
            // decoration: BoxDecoration(
            //   borderRadius: const BorderRadius.all(
            //     Radius.circular(6), //圆jiao
            //   ),
            // image: DecorationImage(
            //   image: NetworkImage(
            //     newsRecommendData.thumbnail,
            //   ),
            //   fit: BoxFit.cover,
            // )
            // ),
            child: CachedNetworkImage(
              imageUrl: newsRecommendData.thumbnail,
              imageBuilder: (context, imageProvider) {
                return Container(
                  //插件切圆角
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),

        //作者
        Container(
          margin: EdgeInsets.only(top: duSetHeight(14)),
          child: Text(
            newsRecommendData.author,
            style: TextStyle(
              fontFamily: 'Avenir',
              fontWeight: FontWeight.normal,
              color: AppColors.thirdElementText,
              fontSize: duSetFontSize(14),
            ),
          ),
        ),
        //标题
        InkWell(
          onTap: () {
            onTap(newsRecommendData);
          },
          child: Container(
            margin: EdgeInsets.only(top: duSetHeight(10)),
            child: Text(
              newsRecommendData.title,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
                fontSize: duSetFontSize(24),
                height: 1,
              ),
            ),
          ),
        ),

        //分类，时间，更多
        Container(
          margin: EdgeInsets.only(top: duSetHeight(10)),
          child: Row(
            children: [
              //分类
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 120),
                child: Text(
                  newsRecommendData.category,
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
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 120),
                child: Text(
                  newsRecommendData.addtime,
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
              // 更多
              const Spacer(),
              InkWell(
                child: const Icon(
                  Icons.more_horiz,
                  color: AppColors.primaryText,
                  size: 24,
                ),
                onTap: () {},
              ),
            ],
          ),
        )
      ],
    ),
  );
}
