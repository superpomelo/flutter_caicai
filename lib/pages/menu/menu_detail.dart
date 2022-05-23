import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_caicai/common/entitys/entitys.dart';
import 'package:flutter_caicai/common/apis/apis.dart';
import 'package:flutter_caicai/common/entitys/menu_detail.dart';
import 'package:flutter_caicai/common/entitys/menu_detail_recommandlist.dart';
import 'package:flutter_caicai/common/entitys/menu_shopcar.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/common/values/values.dart';
import 'package:flutter_caicai/common/widgets/widgets.dart';
import 'package:flutter_caicai/pages/menu/menu_detail_cspec.dart';
import 'package:flutter_caicai/pages/menu/menu_detail_shopcar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:convert';

class MenuDetailPage extends StatefulWidget {
  const MenuDetailPage({Key? key}) : super(key: key);

  @override
  State<MenuDetailPage> createState() => _MenuDetailPageState();
}

class _MenuDetailPageState extends State<MenuDetailPage> {
  bool _bigScroller = true;
  //最大的scroller
  late ScrollController _bigScrollController;
  //右侧分类商品scroller
  late ScrollController _smallScrollController;
  //店铺信息及商品分类信息
  MenuDetailData? _data;
  List<Goodslist> _recommendList = [];
  //购物车数据
  List<ShopCarDatum> _shopcarList = [];

  //订单id
  String? _orderid;
  @override
  void initState() {
    super.initState();
    _bigScrollController = ScrollController();
    _bigScrollController.addListener(() {
      print('_scrollController ${_bigScrollController.offset}');
    });
    _smallScrollController = ScrollController();
    _smallScrollController.addListener(() {
      print('_scrollController ${_smallScrollController.offset}');
      // _bigScrollController
    });
    _loadAllData();
  }

  @override
  void dispose() {
    _bigScrollController.dispose();
    _smallScrollController.dispose();
    super.dispose();
  }

  //读取所有数据
  _loadAllData() async {
    print(Get.arguments);
    //店铺信息
    MenuDetailRequestEntity paramsShopinfo =
        MenuDetailRequestEntity(shopid: Get.arguments);
    MenuDetailResponseEntity resShopinfo =
        await MenuAPI.shopdetail(params: paramsShopinfo);
    //店铺推荐商品
    MenuDetailRecommandlistRequestEntity paramsRecommandlist =
        MenuDetailRecommandlistRequestEntity(shopid: Get.arguments);
    MenuDetailRecommandlistResponseEntity resRecommandlist =
        await MenuAPI.shophomerecommend(params: paramsRecommandlist);
    //购物车信息
    MenuShopcarRequestEntity paramsShopCar =
        MenuShopcarRequestEntity(shopid: Get.arguments);
    MenuShopcarResponseEntity resShopCar =
        await MenuAPI.shopcar(params: paramsShopCar);
    setState(() {
      _data = resShopinfo.data;

      if (resRecommandlist.data.isNotEmpty) {
        _recommendList = resRecommandlist.data[0].goodslist;
      }
      if (resShopCar.data.isNotEmpty) {
        _shopcarList = resShopCar.data;
      }
    });
  }

  //添加商品到购物车
  _addGoodsShopCar() async {
    //对象List转map
    var response = _shopcarList[0].toJson();
    //map取出shopcargoodslist转 jsonstr
    var jsonstr = jsonEncode(response["shopcargoodslist"]);

    print(jsonstr);
    MenuAddgoodsRequestEntity params = MenuAddgoodsRequestEntity(
        shopid: Get.arguments, shopcargoodslist: jsonstr, state: "0");
    MenuAddgoodsResponseEntity res =
        await MenuAPI.changeshopcar(params: params);
    print(res.code);
  }

  //店铺信息
  Widget _buildShopInfo() {
    return _data == null
        ? Container()
        : Container(
            margin: EdgeInsets.fromLTRB(
                duSetWidth(10), duSetHeight(10), duSetWidth(10), 0),
            width: ScreenUtil().screenWidth,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
                child: Container(
                    color: Colors.white,
                    child: Container(
                      margin: EdgeInsets.only(left: duSetWidth(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: duSetWidth(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: duSetWidth(10)),
                                        child: Text(
                                          _data!.shopname,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: 'Avenir',
                                              fontSize: duSetFontSize(18),
                                              color: AppColors.primaryText,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                            duSetWidth(10),
                                            duSetHeight(10),
                                            duSetWidth(0),
                                            0),
                                        child: Text(
                                          _data!.shopaddress,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: 'Avenir',
                                              fontSize: duSetFontSize(14),
                                              color: AppColors.primaryText,
                                              fontWeight: FontWeight.normal,
                                              height: 1.3),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  margin:
                                      EdgeInsets.only(right: duSetWidth(10)),
                                  width: duSetWidth(50),
                                  height: duSetWidth(50),
                                  color: Colors.pink,
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4)),
                                      child: Image.network(
                                        _data!.logourl,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                duSetWidth(10),
                                duSetHeight(5),
                                duSetWidth(10),
                                duSetHeight(10)),
                            child: Text(
                              _data!.shopnotice,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'Avenir',
                                  fontSize: duSetFontSize(14),
                                  color: AppColors.thirdElementText,
                                  fontWeight: FontWeight.normal,
                                  height: 1.3),
                            ),
                          ),
                        ],
                      ),
                    ))));
  }

  //推荐商品
  Widget _buildRecommendGoods() {
    return Container(
      margin: EdgeInsets.only(top: duSetHeight(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: duSetWidth(10)),
            child: Text(
              "商家推荐",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: duSetFontSize(16),
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w600,
                  height: 1.3),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
                duSetWidth(0), duSetHeight(10), duSetWidth(10), 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: _recommendList.map((we) {
                return Container(
                  margin: EdgeInsets.only(left: duSetWidth(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: duSetWidth(0)),
                        child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            child: Container(
                              color: Colors.white,
                              width:
                                  (ScreenUtil().screenWidth - duSetWidth(40)) /
                                      3,
                              height:
                                  (ScreenUtil().screenWidth - duSetWidth(40)) /
                                      3,
                              child: Image.network(
                                we.goodsimgurl,
                              ),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            duSetWidth(0), duSetHeight(5), duSetWidth(0), 0),
                        child: Text(
                          we.goodsname,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: duSetFontSize(14),
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.normal,
                              height: 1.3),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(duSetWidth(0),
                            duSetHeight(20), duSetWidth(0), duSetWidth(10)),
                        width: (ScreenUtil().screenWidth - duSetWidth(40)) / 3,
                        child: Row(
                          children: [
                            Container(
                              child: Text(
                                we.price,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'Avenir',
                                    fontSize: duSetFontSize(14),
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                    height: 1.3),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                print(we.goodsid);

                                //选择规格<2种情况，无规格/有规格>
                                newSpecs(context, we);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: duSetWidth(0)),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  child: Container(
                                    color: Colors.lightBlue,
                                    width: 30,
                                    height: 30,
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  //商品分类
  Widget _buildCatogery() {
    return _data == null
        ? Container()
        : Container(
            margin: EdgeInsets.only(top: duSetHeight(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                      duSetWidth(10), duSetWidth(10), 0, duSetWidth(20)),
                  child: Text(
                    "点餐",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: duSetFontSize(18),
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w600,
                        height: 1.3),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: duSetHeight(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //左侧分类列表
                      Container(
                        color: Colors.blueGrey,
                        // width: duSetWidth(120),
                        // height: duSetHeight(400),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _data!.categorylist.map((e) {
                            return Container(
                              margin: EdgeInsets.only(left: duSetWidth(0)),
                              width: duSetWidth(100),
                              height: duSetHeight(50),
                              child: Center(
                                child: Text(
                                  e.categoryname,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'Avenir',
                                      fontSize: duSetFontSize(16),
                                      color: AppColors.primaryText,
                                      fontWeight: FontWeight.normal,
                                      height: 1.3),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      //右侧分类+商品列表
                      SingleChildScrollView(
                        controller: _smallScrollController,
                        //控制能否滑动
                        physics: _bigScroller
                            ? const NeverScrollableScrollPhysics()
                            : const AlwaysScrollableScrollPhysics(),
                        child: Container(
                          color: Colors.white,
                          width: ScreenUtil().screenWidth - duSetWidth(100),
                          child: Column(
                            children: _data!.categorylist.map((we) {
                              return Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          duSetWidth(10), duSetWidth(10), 0, 0),
                                      child: Text(
                                        we.categoryname,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'Avenir',
                                            fontSize: duSetFontSize(16),
                                            color: AppColors.primaryText,
                                            fontWeight: FontWeight.w600,
                                            height: 1.3),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: duSetWidth(10)),
                                      child: Column(
                                        children: we.goodslist.map((wwe) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                                top: duSetHeight(10)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  4)),
                                                      child: Container(
                                                        color: Colors.white,
                                                        width: (ScreenUtil()
                                                                    .screenWidth -
                                                                duSetWidth(
                                                                    40)) /
                                                            4,
                                                        height: (ScreenUtil()
                                                                    .screenWidth -
                                                                duSetWidth(
                                                                    40)) /
                                                            4,
                                                        child: Image.network(
                                                          wwe.goodsimgurl,
                                                        ),
                                                      )),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: duSetWidth(10)),
                                                  width: ScreenUtil()
                                                          .screenWidth -
                                                      (ScreenUtil()
                                                                  .screenWidth -
                                                              duSetWidth(40)) /
                                                          4 -
                                                      duSetWidth(130),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left:
                                                                duSetWidth(0)),
                                                        child: Text(
                                                          wwe.goodsname,
                                                          textAlign:
                                                              TextAlign.left,
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
                                                              height: 1.3),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top:
                                                                duSetWidth(10)),
                                                        child: Text(
                                                          "月售 ${wwe.monthsel}",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Avenir',
                                                              fontSize:
                                                                  duSetFontSize(
                                                                      14),
                                                              color: AppColors
                                                                  .thirdElementText,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              height: 1.3),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: duSetWidth(
                                                                          10)),
                                                              child: Text(
                                                                "${wwe.price}元",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Avenir',
                                                                    fontSize:
                                                                        duSetFontSize(
                                                                            16),
                                                                    color: Colors
                                                                        .red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    height:
                                                                        1.3),
                                                              ),
                                                            ),
                                                            const Spacer(),
                                                            //商品
                                                            _buildCatogoryGoods(
                                                                wwe)
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
                                    )
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  //创建点餐分类右侧单个商品模块,正常商品
  Widget _buildCatogoryGoods(Goodslist wwe) {
    return InkWell(
      onTap: () {
        //添加商品到购物车 <1.无规格则直接添加，2.有规格弹出选择规格页面>
        if (wwe.specs.isNotEmpty) {
          showModalBottomSheet(
                  isScrollControlled: true, // !important
                  enableDrag: false,
                  builder: (BuildContext context) {
                    return newSpecs(context, wwe);
                  },
                  context: context)
              .then((value) {
            //选完规格回传数据
            Shopcargoodslist shopcargoods = value;
            print(shopcargoods.goodsname);
            print(shopcargoods.choosenum);
            print(shopcargoods.shopcarspces);

            for (var e in _shopcarList[0].shopcargoodslist) {
              // int index = _shopcarList[0].shopcargoodslist.indexOf(e);
              if (e.goodsid == shopcargoods.goodsid) {
                e.choosenum =
                    (int.parse(shopcargoods.choosenum) + int.parse(e.choosenum))
                        .toString();
                _addGoodsShopCar();
                return;
              }
            }

            _shopcarList[0].shopcargoodslist.add(shopcargoods);
            print(_shopcarList[0].shopcargoodslist.length);
            _addGoodsShopCar();
          });
        } else {
          _addGoodsShopCar();
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: duSetWidth(10)),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          child: wwe.specs.isNotEmpty
              ? Container(
                  color: Colors.lightBlue,
                  margin: EdgeInsets.only(top: duSetHeight(0)),
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 2),
                  child: Text(
                    "选规格",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: duSetFontSize(12),
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        height: 1.3),
                  ),
                )
              : Container(
                  color: Colors.lightBlue,
                  margin: EdgeInsets.only(top: duSetHeight(0)),
                  width: 30,
                  height: 30,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }

  //底部模块
  BottomAppBar _buildBottomView(String shopid, String orderid) {
    return BottomAppBar(
        color: AppColors.scaffoldBackground,
        child: InkWell(
          onTap: () {
            print("弹出购物车列表");
            newShopCar(context, _shopcarList, () {
              Get.toNamed("/menudetailconfirm",
                  arguments: {"shopid": shopid, "orderid": orderid});
            });
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
                        print("下单啦 ！");
                        Get.toNamed("/menudetailconfirm", arguments: {
                          "shopid": Get.arguments,
                          "orderid": "22"
                        });
                      }),
                )
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    //设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: const Size(360, 690),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        controller: _bigScrollController,
        //控制能否滑动
        physics: _bigScroller
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        child: Container(
          color: AppColors.tabBarElement,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildShopInfo(),
              _buildRecommendGoods(),
              _buildCatogery(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomView(Get.arguments, _orderid ?? ""),
    );
  }
}
