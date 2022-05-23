import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/common/values/values.dart';
import 'package:flutter_caicai/common/widgets/widgets.dart';
import 'package:flutter_caicai/pages/account/account.dart';
import 'package:flutter_caicai/pages/main/main.dart';
import 'package:flutter_caicai/pages/menu/menu.dart';
import 'package:flutter_caicai/pages/order_list/order_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationFloatPage extends StatefulWidget {
  const ApplicationFloatPage({Key? key}) : super(key: key);

  @override
  State<ApplicationFloatPage> createState() => _ApplicationFloatPageState();
}

class _ApplicationFloatPageState extends State<ApplicationFloatPage> {
  final PageController pageController = PageController();
  int currentIndex = 0;
  int _page = 0;
  final List _tabTitles = ['Welcome', 'Cagegory', 'Bookmarks', 'Account'];

  // // tab栏动画
  // _handleNavBarTap(int index) {
  //   _pageController.animateToPage(index,
  //       duration: const Duration(milliseconds: 200), curve: Curves.ease);
  // }

  // tab栏页码切换
  _handlePageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  //切换tab
  void onIndexChanged(int index) {
    setState(() {
      currentIndex = index;
    });
    _handlePageChanged(index);
    pageController.jumpToPage(index);
  }

// 顶部导航
  PreferredSizeWidget _buildAppBar() {
    return transparentAppBar(
        context: context,
        title: _page == 0
            ? Container()
            : Text(
                _tabTitles[_page],
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: 'Montserrat',
                  fontSize: duSetFontSize(18.0),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.end,
              ),
        leading: const Text(''),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: AppColors.primaryText,
            ),
            onPressed: () {},
          )
        ]);
  }

  // 内容页
  Widget _buildPageView() {
    //设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: const Size(360, 690),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      onPageChanged: onIndexChanged,
      children: const [
        MainPage(),
        MenuPage(),
        OrderListPage(),
        AccountPages(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // 扩展到Scaffold的底部
      resizeToAvoidBottomInset: false, // 不允许键盘事件影响界面
      // appBar: _buildAppBar(),
      // PageController 控制 PageView 呈现页面
      body: _buildPageView(),
      // 底部带凹下的导航
      bottomNavigationBar: BuildNavigation(
        currentIndex: currentIndex,
        items: [
          NavigationItemModel(
            label: "首页",
            icon: SvgIcon.shop,
          ),
          NavigationItemModel(
            label: "点单",
            icon: SvgIcon.layout,
          ),
          NavigationItemModel(
            label: "订单",
            icon: SvgIcon.list,
            count: 0,
          ),
          NavigationItemModel(
            label: "我的",
            icon: SvgIcon.user,
          ),
        ],
        onTap: onIndexChanged, // 切换tab事件
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.add, size: 50),
      // ), // 浮动按钮
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked, // 浮动按钮 停靠在底部中间位置
    );
  }
}
