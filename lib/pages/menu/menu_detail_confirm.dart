import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/apis/apis.dart';
import 'package:flutter_caicai/common/entitys/menu_detail_confirm.dart';
import 'package:flutter_caicai/common/entitys/menu_shopcar.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/common/values/values.dart';
import 'package:flutter_caicai/common/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MenuDetailConfirm extends StatefulWidget {
  MenuDetailConfirm({Key? key}) : super(key: key);

  @override
  State<MenuDetailConfirm> createState() => _MenuDetailConfirmState();
}

class _MenuDetailConfirmState extends State<MenuDetailConfirm> {
  //购物车数据
  List<ShopCarDatum> _shopcarList = [];

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  //读取所有数据
  _loadAllData() async {
    print(Get.arguments);
    //购物车信息
    MenuShopcarRequestEntity paramsShopCar =
        MenuShopcarRequestEntity(shopid: Get.arguments["shopid"]);
    MenuShopcarResponseEntity resShopCar =
        await MenuAPI.shopcar(params: paramsShopCar);
    setState(() {
      if (resShopCar.data.isNotEmpty) {
        _shopcarList = resShopCar.data;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.only(left: duSetWidth(0)),
          child: Text(
            "确认订单",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: 'Avenir',
                fontSize: duSetFontSize(18),
                color: AppColors.primaryText,
                fontWeight: FontWeight.w600,
                height: 1.3),
          ),
        ),
      ),
      body: _shopcarList.isEmpty
          ? Container()
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: duSetHeight(10)),
                width: ScreenUtil().screenWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: _shopcarList[0].shopcargoodslist.map((e) {
                        var _num = e.choosenum.obs; //数量
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(duSetWidth(10), 0,
                                    duSetWidth(10), duSetHeight(5)),
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
                                                5,
                                            height: (ScreenUtil().screenWidth -
                                                    duSetWidth(40)) /
                                                5,
                                            child: Image.network(
                                              e.goodsimgurl,
                                            ),
                                          )),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: duSetWidth(10)),
                                      width: ScreenUtil().screenWidth -
                                          (ScreenUtil().screenWidth -
                                                  duSetWidth(40)) /
                                              5 -
                                          duSetWidth(30),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                                  color: AppColors
                                                      .thirdElementText,
                                                  fontWeight: FontWeight.normal,
                                                  height: 1.3),
                                            ),
                                          ),
                                          //商品单价及数量
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: duSetHeight(10)),
                                            width: ScreenUtil().screenWidth -
                                                (ScreenUtil().screenWidth -
                                                        duSetWidth(40)) /
                                                    5 -
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
                                                      top: duSetWidth(0)),
                                                  child: Text(
                                                    "${e.price}元",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontFamily: 'Avenir',
                                                        fontSize:
                                                            duSetFontSize(16),
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
                                                      right: duSetWidth(10)),
                                                  child: Text(
                                                    "数量 1",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontFamily: 'Avenir',
                                                        fontSize:
                                                            duSetFontSize(16),
                                                        color: AppColors
                                                            .primaryText,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        height: 1.3),
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
                              const Divider(),
                            ]);
                      }).toList(),
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0, duSetHeight(20), duSetWidth(10), 0),
                          child: Text(
                            "合计: 100 元",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Avenir',
                                fontSize: duSetFontSize(16),
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                                height: 1.3),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: duSetWidth(35)),
                        child: Text(
                          "返回修改",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: duSetFontSize(12),
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.normal,
                              height: 1.3),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: duSetHeight(15)),
                      child: btnFlatButtonWidget(
                          onPressed: () async {
                            //购物车信息
                            MenuDetailConfirmRequestEntity paramsConfirm =
                                MenuDetailConfirmRequestEntity(
                                    orderid: Get.arguments["orderid"],
                                    state: "1");
                            MenuDetailConfirmResponseEntity resConfirm =
                                await MenuAPI.confirmorder(
                                    params: paramsConfirm);
                            setState(() {
                              String code = resConfirm.code;
                              print(code);
                              if (code == '200') {
                                Get.offNamed("/menudetailconfirmresult",
                                    arguments: Get.arguments["shopid"]);
                              }
                            });
                          },
                          title: "确认提交",
                          width: 290),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
