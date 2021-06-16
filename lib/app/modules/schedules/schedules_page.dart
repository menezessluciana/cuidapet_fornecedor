import 'package:cuidapet_fornecedor/app/models/schedule_model.dart';
import 'package:cuidapet_fornecedor/app/modules/schedules/components/schedules_appbar.dart';
import 'package:cuidapet_fornecedor/app/shared/theme_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'components/schedule_item_list.dart';
import 'schedules_controller.dart';

class SchedulesPage extends StatefulWidget {
  final String title;
  const SchedulesPage({Key key, this.title = "Schedules"}) : super(key: key);

  @override
  _SchedulesPageState createState() => _SchedulesPageState();
}

class _SchedulesPageState
    extends ModularState<SchedulesPage, SchedulesController> {
  SchedulesAppBar appBar;

  _SchedulesPageState() {
    appBar = SchedulesAppBar(controller);
  }

  @override
  void initState() {
    super.initState();
    controller.initPage();
  }
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar,
        body: RefreshIndicator(
          onRefresh: () => controller.getSchedules(),
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    minWidth: constraints.maxWidth),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      _buildTitleContent(),
                      _buildFilterStatus(),
                      Expanded(child: _buildSchedulesList()),
                      // FlatButton(
                      //     child: Text('logout'),
                      //     onPressed: () async =>
                      //         (await SharedPreferences.getInstance()).clear()),
                    ],
                  ),
                ),
              ),
            );
          }),
        ));
  }

  Widget _buildTitleContent() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Olá, Fornecedor!',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          SizedBox(height: 10),
          Text(
            'Aqui estão todos seus agendamentos para consulta.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterStatus() {
    return Container(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                _buildItemFilter('Cancelado', Icons.cancel_sharp, 'C'),
                _buildItemFilter('Confirmado', Icons.done_sharp, 'CN'),
                _buildItemFilter('Pendente', Icons.pending_sharp, 'P'),
                _buildItemFilter('Finalizado', Icons.done_all_outlined, 'F'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemFilter(String statusLabel, IconData icon, String status) {
    return InkWell(
      onTap: () => controller.filterBySchedulesStatus(status),
      child: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            Observer(builder: (_) {
              return CircleAvatar(
                radius: 30,
                backgroundColor: controller.selectedStatusFilter == status
                    ? ThemeUtils.primaryColorDark
                    : ThemeUtils.primaryColorLight,
                child: Icon(
                  icon,
                  size: 30,
                  color: Colors.grey[800],
                ),
              );
            }),
            SizedBox(height: 10),
            Text(statusLabel)
          ],
        ),
      ),
    );
  }

  Widget _buildSchedulesList() {
    return Observer(builder: (_) {
      return FutureBuilder<List<ScheduleModel>>(
        future: controller.schedulesFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
              break;
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text('Erro ao buscar agendamentos'),
                );
              }
              if (snapshot.hasData) {
                var schedules = snapshot.data;
                return Column(
                  children: schedules
                      .map<Widget>(
                        (s) => ScheduleItemList(s),
                      )
                      .toList(),
                );
              } else {
                return Container();
              }

              break;
            default:
              return Container();
          }
        },
      );
    });
  }
}
