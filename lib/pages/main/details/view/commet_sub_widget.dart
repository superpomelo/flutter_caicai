import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/entitys/home_detail_subcommentlist.dart';
import 'package:flutter_caicai/common/utils/screen.dart';
import 'package:flutter_caicai/common/values/values.dart';

Widget buildsubwidget(List<Writebacklist> we) {
  return //回复评论的评论列表
      Container(
    margin: EdgeInsets.only(top: duSetHeight(10)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: we.map((e) {
        return Container(
          margin: EdgeInsets.fromLTRB(duSetWidth(55), 10, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //头像
              Container(
                margin: EdgeInsets.only(left: duSetWidth(10)),
                padding: EdgeInsets.only(top: duSetHeight(0)),
                height: duSetWidth(25),
                width: duSetWidth(25),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(e.writebackiconurl!),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: duSetWidth(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //昵称
                    Container(
                      margin: EdgeInsets.only(top: duSetHeight(0)),
                      child: Text(
                        e.writebacknickname!,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: duSetFontSize(14),
                            color: AppColors.thirdElementText,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                    ),
                    //内容
                    Container(
                        width: duSetWidth(200),
                        margin: EdgeInsets.only(left: duSetWidth(0)),
                        child: RichText(
                            text: TextSpan(
                                text: e.writebodycontext,
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  fontSize: duSetFontSize(14),
                                  color: AppColors.primaryText,
                                  fontWeight: FontWeight.normal,
                                ),
                                children: [
                              const TextSpan(text: "  "),
                              //时间
                              TextSpan(
                                text: e.writebacktime,
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  fontSize: duSetFontSize(14),
                                  color: AppColors.thirdElementText,
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                            ]))),
                  ],
                ),
              ),
              const Spacer(),
              //喜欢
              InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(right: duSetWidth(10)),
                  child: Column(
                    children: [
                      const Icon(Icons.favorite_border),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Text(
                          e.writebacklikesnum!,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: duSetFontSize(14),
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }).toList(),
    ),
  );
}
