import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/apis/home.dart';
import 'package:flutter_caicai/common/entitys/entitys.dart';
import 'package:flutter_caicai/common/entitys/home_detail_commetlist.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/common/values/values.dart';
import 'package:flutter_caicai/common/widgets/widgets.dart';
import 'package:flutter_caicai/pages/main/main_detail_appbar_widget.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class HomeDetailPage extends StatefulWidget {
  HomeDetailPage({Key? key}) : super(key: key);

  @override
  State<HomeDetailPage> createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  final TextEditingController _contextController = TextEditingController();
  int page = 0;
  HomeDetailData _detailData = HomeDetailData(
      writericonurl: "",
      writerlocation:
          Writerlocation(writeraddress: "", writerlat: "", writerlon: ""),
      writerusername: "",
      focusstatus: "",
      writerimages: [],
      titlecontant: "",
      bodycontant: "",
      time: "",
      islike: "");
  CommetlistData _commetlistData =
      CommetlistData(totalcommentnum: "110", commentlist: []);
  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  _loadAllData() async {
    //详情页内容
    HomeDetailRequestEntity params = HomeDetailRequestEntity(id: "1");
    HomeDetailResponseEntity detail = await TuiJAPI.homedetail(params: params);

    //详情页评论列表
    HomeDetailCommentlistRequestEntity commentlistparams =
        HomeDetailCommentlistRequestEntity(id: "1");
    HomeDetailCommentlistResponseEntity commentlist =
        await TuiJAPI.homedetailcommentlist(params: commentlistparams);

    setState(() {
      _detailData = detail.data;
      _commetlistData = commentlist.data;
    });
  }

  ///分页指示器
  Widget _buildDot(int index) {
    List<Widget> list = [];
    double baseWidth = 6.0;
    double ratio = 3.0;
    int itemCount = _detailData.writerimages.length;
    int floor = page.floor();
    int ceil = page.ceil();
    int preIndex = floor % itemCount;
    int nextIndex = ceil % itemCount;
    double prePercent = page.toDouble() - preIndex;
    double nextPercent = 1 - prePercent;

    double baseOpacity = 0.3;
    double offsetOpacity = 1.0 - baseOpacity;

    for (int i = 0; i < itemCount; ++i) {
      double width;
      double opacity;
      if (i == preIndex) {
        width = baseWidth * (1.0 + ratio * nextPercent);
        opacity = baseOpacity + offsetOpacity * nextPercent;
      } else if (i == nextIndex) {
        width = baseWidth * (1.0 + ratio * prePercent);
        opacity = baseOpacity + offsetOpacity * prePercent;
      } else {
        width = baseWidth;
        opacity = baseOpacity;
      }
      list.add(Container(
        key: Key("zhihupagination_$i"),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        child: ClipRRect(
          borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(3), right: Radius.circular(3)),
          child: Container(
            color: Colors.white.withOpacity(opacity),
            width: width,
            height: 6,
          ),
        ),
      ));
    }
    return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
            padding: const EdgeInsets.only(right: 18, bottom: 18),
            child: Row(mainAxisSize: MainAxisSize.min, children: list)));
  }

  ///轮播图
  Widget _buildImage() {
    return _detailData.writerimages.isEmpty
        ? Container()
        : Container(
            child: Stack(
              children: [
                LiquidSwipe.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      child: Image.network(
                        _detailData.writerimages[index],
                      ),
                    );
                  },
                  itemCount: _detailData.writerimages.length,
                  positionSlideIcon: 0.5,
                  slideIconWidget: const Icon(Icons.arrow_back_ios),
                  onPageChangeCallback: (e) {
                    setState(() {
                      page = e;
                    });
                  },
                  waveType: WaveType.liquidReveal,
                  liquidController: LiquidController(),
                  fullTransitionValue: 880,
                  enableSideReveal: true,
                  enableLoop: true,
                  ignoreUserGestureWhileAnimating: true,
                ),
                Positioned(
                  right: duSetWidth(20),
                  bottom: duSetHeight(15),
                  child: _detailData.writerimages.length == 1
                      ? Container()
                      : _buildDot(page),
                ),
              ],
            ),
          );
  }

  //内容
  Widget _buildContent() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //标题
          Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(
              _detailData.titlecontant,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: duSetFontSize(16),
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w600,
                  height: 1.3),
            ),
          ),
          //内容
          Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(
              _detailData.bodycontant,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: duSetFontSize(14),
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.normal,
                  height: 1.5),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              children: [
                //时间
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text(
                    _detailData.time,
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
                //喜欢
                Container(
                  margin: EdgeInsets.only(right: duSetWidth(10)),
                  child: btnTextButtonBorderOnlyWidget(
                      width: duSetWidth(40),
                      height: duSetHeight(22),
                      onPressed: () {}),
                )
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
        ],
      ),
    );
  }

  ///评论模块
  Widget _buildCommentlist() {
    return Container(
      margin: EdgeInsets.only(top: duSetHeight(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //评论总数
          Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(
              "共 ${_commetlistData.totalcommentnum} 条评论",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: duSetFontSize(16),
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.normal,
                  height: 1.3),
            ),
          ),
          //评论列表
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: _commetlistData.commentlist.map((we) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //头像
                    Container(
                      margin: EdgeInsets.only(top: duSetHeight(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: duSetWidth(20)),
                            height: duSetWidth(35),
                            width: duSetWidth(35),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(we.iconurl),
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
                                  margin: EdgeInsets.all(duSetHeight(0)),
                                  child: Text(
                                    we.nickname,
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
                                    width: duSetWidth(235),
                                    margin:
                                        EdgeInsets.only(left: duSetWidth(0)),
                                    child: RichText(
                                        text: TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                print("点击了富文本");
                                              },
                                            text: we.bodycontext,
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
                                            text: we.time,
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
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 0),
                                    child: Text(
                                      we.likesnum,
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
                    ),
                    //回复评论的评论列表
                    Container(
                      margin: EdgeInsets.only(top: duSetHeight(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: we.writebacklist.map((e) {
                          return Container(
                            margin:
                                EdgeInsets.fromLTRB(duSetWidth(55), 10, 0, 0),
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
                                    backgroundImage:
                                        NetworkImage(e.writebackiconurl),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: duSetWidth(10)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      //昵称
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: duSetHeight(0)),
                                        child: Text(
                                          e.writebacknickname,
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
                                          margin: EdgeInsets.only(
                                              left: duSetWidth(0)),
                                          child: RichText(
                                              text: TextSpan(
                                                  text: e.writebodycontext,
                                                  style: TextStyle(
                                                    fontFamily: 'Avenir',
                                                    fontSize: duSetFontSize(14),
                                                    color:
                                                        AppColors.primaryText,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                  children: [
                                                const TextSpan(text: "  "),
                                                //时间
                                                TextSpan(
                                                  text: e.writebacktime,
                                                  style: TextStyle(
                                                    fontFamily: 'Avenir',
                                                    fontSize: duSetFontSize(14),
                                                    color: AppColors
                                                        .thirdElementText,
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                    margin:
                                        EdgeInsets.only(right: duSetWidth(10)),
                                    child: Column(
                                      children: [
                                        const Icon(Icons.favorite_border),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 10, 10, 0),
                                          child: Text(
                                            e.writebacklikesnum,
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
                    ),
                    //展开更多回复
                    Container(
                      margin: EdgeInsets.fromLTRB(duSetWidth(100), 15, 15, 15),
                      child: Text(
                        "展开 ${we.writebacklistnum} 条回复",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: duSetFontSize(14),
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: duSetWidth(65)),
                      child: const Divider(
                        height: 1,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Future<Widget> _buildInputSub() async {
    return await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container();
        });
  }

  //底部带输入模块
  BottomAppBar _buildInput(BuildContext context) {
    return BottomAppBar(
        color: AppColors.scaffoldBackground,
        child: Container(
            // margin: EdgeInsets.only(bottom: duSetHeight(10)),
            color: AppColors.scaffoldBackground,
            height: kBottomNavigationBarHeight,
            child: Column(
              children: [
                const Divider(
                  height: 1,
                ),
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(duSetWidth(10), 5, 0, 0),
                        child: btnFlatButtonWidget(
                            height: 38,
                            width: 150,
                            title: "说点什么",
                            onPressed: () {
                              /// 弹出文本框
                              showModalBottomSheet(
                                isScrollControlled: true, // !important
                                builder: (BuildContext context) {
                                  return AnimatedPadding(
                                    padding: MediaQuery.of(context)
                                        .viewInsets, // 我们可以根据这个获取需要的padding
                                    duration: const Duration(milliseconds: 100),
                                    child: Container(
                                        child: TextField(
                                      controller: _contextController,
                                      maxLines: null,
                                      keyboardType: TextInputType.text,
                                      autofocus: true,
                                    )),
                                  );
                                },
                                context: context,
                              );
                            }))
                  ],
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: newAppbar(context: context),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, duSetHeight(10), 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildImage(),
                _buildContent(),
                _buildCommentlist(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildInput(context));
  }
}
