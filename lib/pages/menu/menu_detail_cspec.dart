import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/entitys/entitys.dart';
import 'package:flutter_caicai/common/entitys/menu_shopcar.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/common/values/values.dart';
import 'package:flutter_caicai/common/widgets/widgets.dart';
import 'package:flutter_caicai/pages/menu/menu_detail_cspec_bu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//选好了模块
BottomAppBar _buildSelBottomView(
    BuildContext context, List spec, Goodslist goodsinfo, int num) {
  return BottomAppBar(
    color: AppColors.scaffoldBackground,
    elevation: 0, //阴影效果
    child: Container(
      //选好了
      margin: EdgeInsets.fromLTRB(
          duSetWidth(20), 0, duSetWidth(20), duSetWidth(20)),
      child: btnFlatButtonWidget(
          circular: duSetHeight(22),
          width: ScreenUtil().screenWidth - duSetWidth(40),
          title: "选好了",
          onPressed: () {
            List<String> sp = [];
            for (var element in spec) {
              sp.add(element);
            }
            Shopcargoodslist shopcargoods = Shopcargoodslist(
                choosenum: num.toString(),
                goodsid: goodsinfo.goodsid,
                goodsimgurl: goodsinfo.goodsimgurl,
                goodsname: goodsinfo.goodsname,
                monthsel: goodsinfo.monthsel,
                price: goodsinfo.price,
                shopcarspces: sp);
            Navigator.pop(context, shopcargoods);
          }),
    ),
  );
}

//选择规格
Widget newSpecs(BuildContext context, Goodslist goodsinfo) {
  var _num = 0.obs;
  var _spec = [].obs; //选择的规格数组
  // ignore: unused_local_variable
  for (var e in goodsinfo.specs) {
    String temp = "";
    _spec.add(temp);
  }

  return AnimatedPadding(
    padding: MediaQuery.of(context).viewInsets, // 我们可以根据这个获取需要的padding
    duration: const Duration(milliseconds: 100),
    child: Container(
      // color: Colors.white,
      margin: EdgeInsets.only(top: duSetHeight(0)), //设置此参数无效
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenHeight - duSetHeight(100),
      child: Scaffold(
          body: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0, 0, 0, ScreenUtil().bottomBarHeight),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4)),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(duSetHeight(10)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4)),
                                    child: Container(
                                      color: Colors.yellow,
                                      width: (ScreenUtil().screenWidth -
                                              duSetWidth(40)) /
                                          3,
                                      height: (ScreenUtil().screenWidth -
                                              duSetWidth(40)) /
                                          3,
                                      child: Image.network(
                                        goodsinfo.goodsimgurl,
                                      ),
                                    )),
                                Container(
                                  margin:
                                      EdgeInsets.only(left: duSetHeight(10)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      //菜名
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: duSetHeight(0)),
                                        child: Text(
                                          goodsinfo.goodsname,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: 'Avenir',
                                              fontSize: duSetFontSize(18),
                                              color: AppColors.primaryText,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3),
                                        ),
                                      ),
                                      //选择的规格展示
                                      Container(
                                          margin: EdgeInsets.only(
                                              top: duSetHeight(5)),
                                          child: Obx(() {
                                            String str = "";
                                            for (var element in _spec) {
                                              int num = _spec.indexOf(element);
                                              if (num > 0 && element != "") {
                                                str = str + "/";
                                              }
                                              str = str + element;
                                            }
                                            return Text(
                                              // ignore: unnecessary_brace_in_string_interps
                                              "已选: ${str}",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontFamily: 'Avenir',
                                                  fontSize: duSetFontSize(14),
                                                  color: AppColors
                                                      .thirdElementText,
                                                  fontWeight: FontWeight.normal,
                                                  height: 1.3),
                                            );
                                          })),
                                      //价格
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: duSetHeight(25)),
                                        child: Text(
                                          "108元",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: 'Avenir',
                                              fontSize: duSetFontSize(18),
                                              color: Colors.red,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          //数量
                          Container(
                            margin: EdgeInsets.only(top: duSetHeight(10)),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: duSetWidth(10)),
                                  child: Text(
                                    "数量",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: 'Avenir',
                                        fontSize: duSetFontSize(16),
                                        color: AppColors.primaryText,
                                        fontWeight: FontWeight.w600,
                                        height: 1.3),
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    if (_num.value > 0) {
                                      _num.value--;
                                    }
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(right: duSetWidth(10)),
                                    child: const Icon(Icons.remove),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                        duSetWidth(15),
                                        duSetWidth(5),
                                        duSetWidth(15),
                                        duSetWidth(5)),
                                    color: Colors.blueGrey,
                                    child: Center(
                                        child: Obx(() => Text(
                                              _num.value.toString(),
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontFamily: 'Avenir',
                                                  fontSize: duSetFontSize(16),
                                                  color: AppColors.primaryText,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.3),
                                            ))),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _num.value++;
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        duSetWidth(10), 0, duSetWidth(10), 0),
                                    child: const Icon(Icons.add),
                                  ),
                                )
                              ],
                            ),
                          ),
                          //规格
                          SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(duSetWidth(10),
                                  duSetHeight(5), duSetWidth(10), 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: goodsinfo.specs.map((e) {
                                  return Container(
                                    margin:
                                        EdgeInsets.only(top: duSetHeight(0)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: duSetHeight(25)),
                                          child: Text(
                                            e.categoryspecname,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontFamily: 'Avenir',
                                                fontSize: duSetFontSize(16),
                                                color: AppColors.primaryText,
                                                fontWeight: FontWeight.w600,
                                                height: 1.3),
                                          ),
                                        ),
                                        //流布局
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: duSetHeight(10)),
                                          child: Wrap(
                                            spacing: 10.0,
                                            runSpacing: 5.0,
                                            children: e.speclist.map((we) {
                                              //创建每一个小规格
                                              return Obx(() {
                                                return newBluSpec(
                                                    spec: _spec,
                                                    we: we,
                                                    goodsinfo: goodsinfo,
                                                    e: e);
                                              });
                                            }).toList(),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Obx(() =>
              _buildSelBottomView(context, _spec, goodsinfo, _num.value))),
    ),
  );
}
