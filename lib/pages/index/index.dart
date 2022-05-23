import 'package:flutter/material.dart';
import 'package:flutter_caicai/global.dart';
import 'package:flutter_caicai/pages/application/application_float.dart';
import 'package:flutter_caicai/pages/sign_in/sign_in.dart';
import 'package:flutter_caicai/pages/welcome.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    //设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕。
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: const Size(360, 690),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return Global.isFirstOpen == true
        ? const WelcomePage()
        : Global.isOfflineLogin == true
            ? const ApplicationFloatPage()
            : const signInPage();
  }
}
