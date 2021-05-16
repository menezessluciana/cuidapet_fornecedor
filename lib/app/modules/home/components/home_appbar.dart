import 'package:cuidapet_fornecedor/app/modules/home/home_controller.dart';
import 'package:cuidapet_fornecedor/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/screenutil.dart';

class HomeAppBar extends PreferredSize {
  final HomeController controller;
  HomeAppBar(this.controller)
      : super(
          preferredSize: Size(double.infinity, 100),
          child: AppBar(
            backgroundColor: Colors.grey[100],
            title: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text('Cuidapet', style: TextStyle(color: Colors.white)),
            ),
            elevation: 0,
            flexibleSpace: Stack(
              children: <Widget>[
                Container(
                  height: 110,
                  width: double.infinity,
                  color: ThemeUtils.primaryColor,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: ScreenUtil.screenWidthDp * .9,
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(30),
                      child: Observer(builder: (_) {
                        return TextFormField(
                          // onChanged: (nome) =>
                          //     controller.filtrarEstabelecimentoPorNome(),
                          // controller: controller.filtroNomeController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Icon(Icons.search, size: 30),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.grey[200],
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.grey[200],
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.grey[200],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
}
