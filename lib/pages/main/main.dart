import 'dart:async';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/apis/apis.dart';
import 'package:flutter_caicai/common/entitys/entitys.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/common/values/values.dart';
import 'package:flutter_caicai/common/widgets/widgets.dart';
import 'package:flutter_caicai/pages/main/staggered_widget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late EasyRefreshController _controller; // EasyRefresh控制器
  //admob
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  late AdmobInterstitial interstitialAd;
  late AdmobReward rewardAd;
  // final List<Map<String, dynamic>> _items = List.generate(
  //     200,
  //     (index) => {
  //           "id": index,
  //           "title": "Item $index",
  //           "height": Random().nextInt(150) + 50.5
  //         });
  List<HomeDatum> _homeData = [];
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _loadAllData();
    _loadLatestWithDiskCache();
  }

  // 如果有磁盘缓存，延迟3秒拉取更新档案
  _loadLatestWithDiskCache() {
    if (CACHE_ENABLE == true) {
      var cacheData = StorageUtil().getJSON(STORAGE_INDEX_NEWS_CACHE_KEY);
      if (cacheData != null) {
        Timer(const Duration(seconds: 3), () {
          _controller.callRefresh();
        });
      }
    }
  }

  //读取所有数据
  _loadAllData() async {
    // _controller.callRefresh(); //通知刷新
    interstitialAd = AdmobInterstitial(
      adUnitId: getInterstitialAdUnitId()!,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        // handleEvent(event, args, 'Interstitial');
      },
    );

    rewardAd = AdmobReward(
      adUnitId: getRewardBasedVideoAdUnitId()!,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) rewardAd.load();
        // handleEvent(event, args, 'Reward');
      },
    );
    interstitialAd.load();
    rewardAd.load();

    HomeItemResponseEntity home = await TuiJAPI.home();
    setState(() {
      _homeData = home.data;
    });
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    rewardAd.dispose();
    super.dispose();
  }

  //tabs1,2
  Widget _buildtab1() {
    return _homeData.isEmpty
        ? cardListSkeleton()
        : EasyRefresh(
            // enableControlFinishRefresh: true,
            controller: _controller,
            header: ClassicalHeader(),
            onRefresh: () async {
              _controller.resetLoadState();
              await Future.delayed(const Duration(seconds: 2), () {
                // ignore: avoid_print
                print('onRefresh');
                setState(() {
                  // _count = 20;
                  _controller.finishRefresh();
                });
              });
            },
            //瀑布流
            child: SingleChildScrollView(
                child: newStaggeredDrid(
                    homeData: _homeData,
                    onTap: (e) {
                      Get.toNamed('/homedetail');
                    })));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: TabBar(
              labelColor: Colors.pink,
              labelStyle: TextStyle(
                color: AppColors.thirdElementText,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w500,
                fontSize: duSetFontSize(18),
                height: 1,
              ),
              unselectedLabelColor: Colors.black45,
              isScrollable: true,
              indicatorColor: Colors.pink,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.only(bottom: duSetHeight(10)),
              tabs: const [
                Tab(
                  text: '推荐',
                ),
                Tab(
                  text: '南昌',
                ),
              ],
            ),
            leading: const Text(''),
            actions: const [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: Icon(Icons.search),
              ),
            ],
          ),
          body: TabBarView(
            children: [
              _buildtab1(),
              _buildtab1(),
            ],
          ),
        ));
  }
}
