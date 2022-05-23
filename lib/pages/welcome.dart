import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/common/values/values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelconmePageState();
}

//页头标题
Widget _buildPageHeadTitle() {
  return Container(
    margin: EdgeInsets.only(top: duSetHeight(60)),
    child: Text(
      "Features",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.primaryText,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w600,
        fontSize: duSetFontSize(24),
      ),
    ),
  );
}

//页头说明
Widget _buildPageHeadDetail() {
  return Container(
    width: duSetWidth(242),
    height: duSetHeight(70),
    margin: EdgeInsets.only(top: duSetHeight(14)),
    child: Text(
      "The best of news channels all in one place. Trusted sources and personalized news for you.",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: AppColors.primaryText,
          fontFamily: "Avenir",
          fontWeight: FontWeight.normal,
          fontSize: duSetFontSize(16),
          height: 1.3),
    ),
  );
}

//特性说明
Widget _buildFeatureItem(String imageName, String intro, double marginTop) {
  return Container(
    width: duSetWidth(295),
    height: duSetHeight(80),
    margin: EdgeInsets.only(top: duSetHeight(marginTop)),
    child: Row(
      children: [
        // ignore: sized_box_for_whitespace
        Container(
          width: duSetWidth(80),
          height: duSetWidth(80),
          child: Image.asset(
            "assets/images/$imageName.png",
            fit: BoxFit.none,
          ),
        ),
        const Spacer(),
        // ignore: sized_box_for_whitespace
        Container(
          width: duSetWidth(195),
          child: Text(
            intro,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: "Avenir",
                fontWeight: FontWeight.normal,
                fontSize: duSetFontSize(16)),
          ),
        )
      ],
    ),
  );
}

//开始按钮
Widget _buildPageHeadButton(BuildContext context) {
  return Container(
      width: duSetWidth(295),
      height: duSetHeight(44),
      margin: EdgeInsets.only(bottom: duSetHeight(20)),
      child: TextButton(
        child: Text('Get started',
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Avenir",
              fontWeight: FontWeight.normal,
              fontSize: duSetFontSize(16),
            )),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(AppColors.primaryElement),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(duSetWidth(6)))))),
        onPressed: () {
          Navigator.pushNamed(context, "/sign_in");
        },
      ));
}

class _WelconmePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    // 高度去掉 顶部、底部 导航
    // ScreenUtil.init(constraints );
    return Scaffold(
      body: Center(
        // ignore: avoid_unnecessary_containers
        child: Container(
            child: Column(
          children: [
            _buildPageHeadTitle(),
            _buildPageHeadDetail(),
            _buildFeatureItem(
              "feature-1",
              "Compelling photography and typography provide a beautiful reading",
              86,
            ),
            _buildFeatureItem(
              "feature-2",
              "Sector news never shares your personal data with advertisers or publishers",
              40,
            ),
            _buildFeatureItem(
              "feature-3",
              "You can get Premium to unlock hundreds of publications",
              40,
            ),
            const Spacer(),
            _buildPageHeadButton(context)
          ],
        )),
      ),
    );
  }
}
