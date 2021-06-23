import 'package:cuidapet_fornecedor/app/modules/schedules/schedules_controller.dart';
import 'package:cuidapet_fornecedor/app/repositories/shared_prefs_repository.dart';
import 'package:cuidapet_fornecedor/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';

class SchedulesAppBar extends PreferredSize {
  final SchedulesController controller;
  SchedulesAppBar(this.controller)
      : super(
          preferredSize: Size(double.infinity, 110),
          child: AppBar(
            backgroundColor: Colors.grey[100],
            title: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text('Cuidapet', style: TextStyle(color: Colors.white)),
            ),
            leading: IconButton(
              icon: Icon(Icons.chat_outlined, color: Colors.white),
              onPressed: () async {
                Modular.to.pushNamed('/chats');
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.logout, color: Colors.white),
                onPressed: () async {
                  final prefs = await SharedPrefsRepository.instance;
                  await prefs.logout();
                },
              ),
            ],
            elevation: 0,
            flexibleSpace: Stack(
              children: <Widget>[
                Container(
                  height: 100,
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
                          onChanged: (nome) =>
                              controller.filterSchedulesByPetName(),
                          controller: controller.nameFilterController,
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
