import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/entitys/entitys.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/common/values/values.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

///瀑布流
Widget newStaggeredDrid(
    {required List<HomeDatum> homeData, required Function(HomeDatum) onTap}) {
  return Container(
    color: AppColors.scaffoldBackground,
    child: Container(
      margin: EdgeInsets.all(duSetWidth(5)),
      color: Colors.transparent,
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        physics:
            const NeverScrollableScrollPhysics(), //本身不滚动，让外面的singlescrollview来滚动
        shrinkWrap: true, //收缩，让外面的singlescrollview来滚动
        itemCount: homeData.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              onTap(homeData[index]);
            },
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.primaryBackground,
                boxShadow: [
                  Shadows.primaryShadow,
                ],
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //切圆角最好用这种widget
                  ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(2),
                          topRight: Radius.circular(2)),
                      child: Image.network(
                        homeData[index].imageurl,
                      )),
                  // Container(
                  //   child: CachedNetworkImage(
                  //     imageUrl: _items[index]["imageurl"],
                  //     imageBuilder: (context, imageProvider) {
                  //       return Container(
                  //         //插件切圆角
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           image: DecorationImage(
                  //             image: imageProvider,
                  //             // fit: BoxFit.cover,
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //     placeholder: (context, url) =>
                  //         const CircularProgressIndicator(),
                  //     errorWidget: (context, url, error) =>
                  //         const Icon(Icons.error),
                  //   ),
                  // ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        duSetWidth(10), duSetHeight(10), duSetWidth(10), 0),
                    child: Text(
                      homeData[index].title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Avenir',
                          fontSize: duSetFontSize(14),
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w600,
                          height: 1.3),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0, duSetHeight(10), 0, duSetHeight(10)),
                    child: Row(
                      children: [
                        // ignore: sized_box_for_whitespace
                        Container(
                          margin: EdgeInsets.only(left: duSetWidth(10)),
                          height: duSetHeight(20),
                          width: duSetHeight(20),
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(homeData[index].iconurl),
                          ),
                        ),
                        // ignore: avoid_unnecessary_containers
                        Container(
                          margin: EdgeInsets.only(left: duSetWidth(10)),
                          child: Text(
                            homeData[index].username,
                            style: TextStyle(
                                fontFamily: 'Avenir',
                                fontSize: duSetFontSize(12),
                                color: AppColors.thirdElementText,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          margin: EdgeInsets.only(right: duSetWidth(10)),
                          child: Row(
                            children: [
                              // ignore: avoid_unnecessary_containers
                              Container(
                                  child: const Icon(
                                Icons.favorite_border,
                                size: 15.0,
                                color: Colors.black45,
                              )),
                              // ignore: avoid_unnecessary_containers
                              Container(
                                child: Text(
                                  homeData[index].hot,
                                  style: TextStyle(
                                      fontFamily: 'Avenir',
                                      fontSize: duSetFontSize(12),
                                      color: AppColors.thirdElementText,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
