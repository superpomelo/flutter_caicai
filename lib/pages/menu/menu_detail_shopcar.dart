import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/entitys/menu_shopcar.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/common/values/values.dart';
import 'package:flutter_caicai/common/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//底部模块
BottomAppBar _buildShopCarBottomView(
    BuildContext context, VoidCallback onPressed) {
  return BottomAppBar(
      color: AppColors.scaffoldBackground,
      //elevation: 0, //阴影效果
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          margin: EdgeInsets.only(top: duSetHeight(10)),
          child: Row(
            children: [
              Container(
                  margin: EdgeInsets.only(left: duSetWidth(10)),
                  child: Stack(
                    children: [
                      const Positioned(
                        child: Icon(
                          Icons.child_friendly,
                          size: 50.0,
                          color: Colors.lightBlue,
                        ),
                      ),
                      Positioned(
                          top: 5,
                          right: 0,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: Container(
                              color: Colors.red,
                              padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                              height: 20,
                              width: 20,
                              child: Text(
                                "3",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Avenir',
                                    fontSize: duSetFontSize(12),
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    height: 1.3),
                              ),
                            ),
                          ))
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(left: duSetWidth(10)),
                child: Text(
                  "10元",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: duSetFontSize(18),
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      height: 1.3),
                ),
              ),
              const Spacer(),
              Container(
                margin: EdgeInsets.only(right: duSetWidth(10)),
                child: btnFlatButtonWidget(
                    circular: duSetHeight(44) / 2,
                    title: "去下单",
                    onPressed: () {
                      onPressed();
                      // print("下单啦 ！");
                      // Get.toNamed("/menudetailconfirm", arguments: "");
                    }),
              )
            ],
          ),
        ),
      ));
}

//购物车
newShopCar(BuildContext context, List<ShopCarDatum> shopcarList,
    VoidCallback onPressed) {
  showModalBottomSheet(
      isScrollControlled: true, // !important
      enableDrag: false,
      builder: (BuildContext context) {
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets, // 我们可以根据这个获取需要的padding
          duration: const Duration(milliseconds: 100),
          child: Container(
            margin: EdgeInsets.only(
                top: duSetHeight(0)), //因为showModalBottomSheet所以设置此属性无效
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight -
                ScreenUtil().screenHeight / 2 +
                duSetHeight(150),
            child: Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        duSetWidth(10), duSetHeight(15), 0, duSetHeight(10)),
                    child: Text(
                      "已选商品",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Avenir',
                          fontSize: duSetFontSize(16),
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w600,
                          height: 1.3),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(bottom: duSetHeight(0)),
                      width: ScreenUtil().screenWidth,
                      child: Column(
                        children: shopcarList[0].shopcargoodslist.map((e) {
                          var _num = e.choosenum.obs; //数量
                          return Container(
                            margin: EdgeInsets.fromLTRB(duSetWidth(10), 0,
                                duSetWidth(10), duSetHeight(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //商品图片
                                Container(
                                  color: Colors.yellow,
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4)),
                                      child: Container(
                                        color: Colors.white,
                                        width: (ScreenUtil().screenWidth -
                                                duSetWidth(40)) /
                                            4,
                                        height: (ScreenUtil().screenWidth -
                                                duSetWidth(40)) /
                                            4,
                                        child: Image.network(
                                          e.goodsimgurl,
                                        ),
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: duSetWidth(10)),
                                  width: ScreenUtil().screenWidth -
                                      (ScreenUtil().screenWidth -
                                              duSetWidth(40)) /
                                          4 -
                                      duSetWidth(30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //商品名
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: duSetWidth(0)),
                                        child: Text(
                                          e.goodsname,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: 'Avenir',
                                              fontSize: duSetFontSize(16),
                                              color: AppColors.primaryText,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3),
                                        ),
                                      ),
                                      //选择的商品规格
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: duSetWidth(10)),
                                        child: Text(
                                          "规格",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: 'Avenir',
                                              fontSize: duSetFontSize(14),
                                              color: AppColors.thirdElementText,
                                              fontWeight: FontWeight.normal,
                                              height: 1.3),
                                        ),
                                      ),
                                      //商品单价及数量修改
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: duSetHeight(0)),
                                        width: ScreenUtil().screenWidth -
                                            (ScreenUtil().screenWidth -
                                                    duSetWidth(40)) /
                                                4 -
                                            duSetWidth(30),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            //商品单价
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: duSetWidth(10)),
                                              child: Text(
                                                "${e.price}元",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily: 'Avenir',
                                                    fontSize: duSetFontSize(16),
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    height: 1.3),
                                              ),
                                            ),
                                            const Spacer(),
                                            //数量修改
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: duSetWidth(0)),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      // if (int.parse(e.choosenum)  > 0) {
                                                      //   int.parse(e.choosenum)--;
                                                      // }
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          right:
                                                              duSetWidth(10)),
                                                      child: Icon(Icons.remove),
                                                    ),
                                                  ),
                                                  ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(4)),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              duSetWidth(15),
                                                              duSetWidth(5),
                                                              duSetWidth(15),
                                                              duSetWidth(5)),
                                                      color: Colors.blueGrey,
                                                      child: Center(
                                                          child: Obx(() => Text(
                                                                _num.value,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Avenir',
                                                                    fontSize:
                                                                        duSetFontSize(
                                                                            16),
                                                                    color: AppColors
                                                                        .primaryText,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    height:
                                                                        1.3),
                                                              ))),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      // _num.value++;
                                                    },
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              duSetWidth(10),
                                                              0,
                                                              duSetWidth(0),
                                                              0),
                                                      child:
                                                          const Icon(Icons.add),
                                                    ),
                                                  )
                                                ],
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
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: _buildShopCarBottomView(context, () {
                onPressed();
              }),
            ),
          ),
        );
      },
      context: context);
}
