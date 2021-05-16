import 'package:cuidapet_fornecedor/app/modules/home/components/home_appbar.dart';
import 'package:cuidapet_fornecedor/app/shared/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  HomeAppBar appBar;
  //use 'controller' variable to access controller

  _HomePageState() {
    appBar = HomeAppBar(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          width: ScreenUtil.screenWidthDp,
          //*para ajustar o scroll da tela e não dar scroll na appbar
          height: ScreenUtil.screenHeightDp -
              (appBar.preferredSize.height + ScreenUtil.statusBarHeight),
          child: Column(
            children: <Widget>[
              // _buildEndereco(),
              // _buildCategorias(),
              // Expanded(child: _buildEstabelecimentos()),
            ],
          ),
        ),
      ),
    );
  }
}
