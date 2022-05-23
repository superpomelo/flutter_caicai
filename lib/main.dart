import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/values/values.dart';
import 'package:flutter_caicai/global.dart';
import 'package:flutter_caicai/pages/index/index.dart';
import 'package:flutter_caicai/routes.dart';
import 'package:get/get.dart';

void main() => Global.init().then((e) => runApp(const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        getPages: getRoutes(),
        title: 'Material App',
        theme: AppTheme.light,
        home: const IndexPage());
  }
}
