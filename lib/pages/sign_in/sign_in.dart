import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/apis/apis.dart';
import 'package:flutter_caicai/common/entitys/user.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/common/values/values.dart';
import 'package:flutter_caicai/common/widgets/widgets.dart';
import 'package:flutter_caicai/global.dart';
import 'package:flutter_caicai/pages/application/application_float.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class signInPage extends StatefulWidget {
  const signInPage({Key? key}) : super(key: key);

  @override
  State<signInPage> createState() => _signInPageState();
}

// ignore: camel_case_types
class _signInPageState extends State<signInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  //登录
  _handelSignIn(BuildContext context) async {
    UserLoginRequestEntity params = UserLoginRequestEntity(
        email: _emailController.value.text,
        password: duSHA256(_passController.value.text));
    UserLoginResponseEntity res = await UserAPI.login(params: params);
    //保存个人信息
    Global.saveProfile(res);
    Get.to(const ApplicationFloatPage(), arguments: {});
    // Navigator.pushNamed(context, "/application");
  }

  //logo
  Widget _buildLogo() {
    return Container(
      width: duSetWidth(101),
      margin: EdgeInsets.only(top: duSetHeight(40 + 44.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: duSetHeight(76),
            width: duSetWidth(76),
            margin: EdgeInsets.symmetric(horizontal: duSetWidth(15)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: duSetHeight(76),
                    decoration: BoxDecoration(
                        color: AppColors.primaryBackground,
                        boxShadow: const [Shadows.primaryShadow],
                        borderRadius: BorderRadius.all(
                            Radius.circular(duSetWidth(76 * 0.5)))),
                    child: Container(),
                  ),
                ),
                Positioned(
                    top: duSetWidth(13),
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.none,
                    ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: duSetHeight(15)),
            child: Text(
              '菜菜子',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                  fontSize: duSetFontSize(24),
                  height: 1),
            ),
          ),
          Text(
            '',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: "Avenir",
                fontWeight: FontWeight.w400,
                fontSize: duSetFontSize(16),
                height: 1),
          )
        ],
      ),
    );
  }

  //登录表单
  Widget _buildInputForm(BuildContext context) {
    return Container(
      width: duSetWidth(295),
      margin: EdgeInsets.only(top: duSetHeight(49)),
      child: Column(
        children: [
          inputTextEdit(
              controller: _emailController, hintText: "邮箱", marginTop: 0),
          inputTextEdit(
              controller: _passController, hintText: "密码", isPassWord: true),
          Container(
            height: duSetHeight(44),
            margin: EdgeInsets.only(top: duSetHeight(15)),
            child: Row(
              children: [
                btnFlatButtonWidget(
                    onPressed: () {
                      Navigator.pushNamed(context, "/sign_up");
                    },
                    gbColor: AppColors.thirdElement,
                    title: "注 册"),
                const Spacer(),
                btnFlatButtonWidget(
                    onPressed: () {
                      _handelSignIn(context);
                    },
                    gbColor: AppColors.primaryElement,
                    title: "登 录"),
              ],
            ),
          ),
          Container(
            height: duSetHeight(44),
            margin: EdgeInsets.only(top: duSetHeight(20)),
            child: TextButton(
                onPressed: () {
                  Get.toNamed('/lost_password');
                },
                child: Text(
                  "忘记密码?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.secondaryElementText,
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.w400,
                      fontSize: duSetFontSize(16),
                      height: 1 // 设置下行高，否则字体下沉
                      ),
                )),
          )
        ],
      ),
    );
  }

  //三方登录
  Widget _buildThirdPartLogin() {
    return Container(
      width: duSetWidth(295),
      margin: EdgeInsets.only(bottom: duSetHeight(40)),
      child: Column(
        children: [
          Text("Or sign in with social networks",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.w400,
                  fontSize: duSetFontSize(16))),
          Padding(
            padding: EdgeInsets.only(top: duSetHeight(20)),
            child: btnTextButtonBorderOnlyWidget(onPressed: () {}),
          )
        ],
      ),
    );
  }

  //注册按钮
  Widget _buildSignUpButton() {
    return Container(
      margin: EdgeInsets.only(bottom: duSetHeight(20)),
      child: btnFlatButtonWidget(
          onPressed: () {
            Navigator.pushNamed(context, "/sign_up");
          },
          width: 294,
          gbColor: AppColors.secondaryElement,
          fontColor: AppColors.primaryText,
          title: "去注册",
          fontWeight: FontWeight.w500,
          fontSize: 16),
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
      body: Center(
        child: Column(
          children: [
            _buildLogo(),
            _buildInputForm(context),
            const Spacer(),
            _buildThirdPartLogin(),
            _buildSignUpButton()
          ],
        ),
      ),
    );
  }
}
