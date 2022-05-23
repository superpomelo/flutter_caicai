import 'package:flutter_caicai/common/entitys/menu_detail_confirm.dart';
import 'package:flutter_caicai/main.dart';
import 'package:flutter_caicai/pages/application/application_float.dart';
import 'package:flutter_caicai/pages/lost_password/lost_password.dart';
import 'package:flutter_caicai/pages/main/main_detail.dart';
import 'package:flutter_caicai/pages/menu/menu_detail.dart';
import 'package:flutter_caicai/pages/menu/menu_detail_confirm.dart';
import 'package:flutter_caicai/pages/menu/menu_detail_confirm_result.dart';
import 'package:flutter_caicai/pages/publish/publish.dart';
import 'package:get/get.dart';
import 'pages/sign_in/sign_in.dart';
import 'pages/sign_up/sign_up.dart';

///命名路由
List<GetPage> getRoutes() {
  List<GetPage> routes = [
    GetPage(name: '/', page: () => const MyApp()),
    GetPage(name: '/sign_in', page: () => const signInPage()),
    GetPage(name: '/sign_up', page: () => const signUpPage()),
    GetPage(name: '/lost_password', page: () => const LostPasswordPage()),
    GetPage(name: '/gettest2', page: () => const ApplicationFloatPage()),
    GetPage(name: '/publish', page: () => const PublishPage()),
    GetPage(name: '/homedetail', page: () => HomeDetailPage()),
    GetPage(name: '/menudetail', page: () => const MenuDetailPage()),
    GetPage(name: '/menudetailconfirm', page: () => MenuDetailConfirm()),
    GetPage(
        name: '/menudetailconfirmresult',
        page: () => MenuDetailConfirmResult()),
  ];
  return routes;
}
