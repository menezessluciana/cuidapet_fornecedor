import 'package:cuidapet_fornecedor/app/shared/auth_store.dart';
import 'package:cuidapet_fornecedor/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Chamada depois que a página é construida
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final authStore = Modular.get<AuthStore>();
      final isLogged = await authStore.isLogged();
      if (isLogged) {
        await authStore.loadUser();
        Modular.to.pushNamedAndRemoveUntil('/home', (_) => false);
      } else {
        Modular.to.pushNamedAndRemoveUntil('/login', (_) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    ThemeUtils.init(context);
    return Scaffold(
      body: Center(
          child: Container(child: Image.asset('lib/assets/images/logo.png'))),
    );
  }
}
