import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_caicai/common/apis/apis.dart';
import 'package:flutter_caicai/common/entitys/entitys.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/common/values/values.dart';
import 'package:flutter_caicai/common/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final TextEditingController _controller = TextEditingController();
  List<MenuDatum> _recommendlistData = [];
  //搜索
  Widget _buildSearch() {
    return Container(
        margin: EdgeInsets.fromLTRB(
            duSetWidth(10), duSetHeight(0), duSetWidth(10), 0),
        child: inputTextEdit(
            marginTop: duSetHeight(10),
            controller: _controller,
            hintText: "输入要搜索的店铺"));
  }

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  //读取所有数据
  _loadAllData() async {
    MenuCommentlistRequestEntity params =
        MenuCommentlistRequestEntity(lat: '', lon: '');
    MenuCommentlistResponseEntity res = await MenuAPI.recommend(params: params);
    // // 设置当前状态栏颜色为白色
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    setState(() {
      _recommendlistData = res.data;
    });
  }

  //点单
  Widget _buildMenu() {
    return Container(
      margin: EdgeInsets.fromLTRB(
          duSetWidth(10), duSetHeight(10), duSetWidth(10), 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
        child: Container(
          // margin: EdgeInsets.only(top: duSetHeight(10)),
          width: ScreenUtil().screenWidth,
          height: duSetHeight(200),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: duSetHeight(20)),
                child: Image.asset(
                  "assets/images/menu.png",
                  width: duSetHeight(100),
                  height: duSetHeight(100),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: duSetHeight(20)),
                child: Text(
                  "点单",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                    fontSize: duSetFontSize(24),
                    height: 1,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //推荐店铺
  Widget newShop(MenuDatum e) {
    return InkWell(
      onTap: () {
        Get.toNamed("menudetail", arguments: e.shopid);
      },
      child: Container(
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
              margin: EdgeInsets.only(top: duSetHeight(10)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: duSetWidth(10)),
                    width: duSetWidth(50),
                    height: duSetWidth(50),
                    color: Colors.pink,
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        child: Image.network(
                          e.logourl,
                        )),
                  ),
                  Container(
                    // margin: EdgeInsets.fromLTRB(
                    //     duSetWidth(10), duSetHeight(0), duSetWidth(10), 0),
                    margin: EdgeInsets.only(left: duSetWidth(10)),
                    // color: Colors.blueGrey,
                    width: ScreenUtil().screenWidth - duSetWidth(90),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: duSetWidth(0)),
                          child: Text(
                            e.shopname,
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
                              duSetWidth(0),
                              duSetHeight(10),
                              duSetWidth(10),
                              0), // height: duSetHeight(45),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: duSetWidth(0)),
                                width: duSetWidth(200),
                                child: Text(
                                  e.shopaddress,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'Avenir',
                                      fontSize: duSetFontSize(14),
                                      color: AppColors.thirdElementText,
                                      fontWeight: FontWeight.normal,
                                      height: 1.3),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                margin: EdgeInsets.only(right: duSetWidth(0)),
                                child: Text(
                                  e.howfar,
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
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              duSetWidth(0), duSetHeight(10), duSetWidth(0), 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: e.goodslist.map((we) {
                              return Container(
                                margin: EdgeInsets.only(left: duSetWidth(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: duSetWidth(0)),
                                      child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(4)),
                                          child: Container(
                                            color: Colors.white,
                                            width: duSetHeight(80),
                                            height: duSetHeight(80),
                                            child: Image.network(
                                              we.goodsimgurl,
                                            ),
                                          )),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(duSetWidth(0),
                                          duSetHeight(5), duSetWidth(0), 0),
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
                                      margin: EdgeInsets.fromLTRB(
                                          duSetWidth(0),
                                          duSetHeight(5),
                                          duSetWidth(0),
                                          duSetWidth(10)),
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
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//推荐店铺
  Widget _buildRecommendShop() {
    return Container(
      child: _recommendlistData.isEmpty
          ? Container()
          : Column(
              children: _recommendlistData.map((e) {
              return newShop(e);
            }).toList()),
    );
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
      /*可以通过设置 这个属性 防止键盘 覆盖内容 或者 键盘 撑起内容*/
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        elevation: 0,
        title: _buildSearch(),
      ),
      body: Container(
        color: AppColors.tabBarElement,
        margin: EdgeInsets.only(top: duSetHeight(10)),
        child: Column(
          children: [_buildMenu(), _buildRecommendShop()],
        ),
      ),
    );
  }
}
