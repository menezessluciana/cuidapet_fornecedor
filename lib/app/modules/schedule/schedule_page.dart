import 'package:cuidapet_fornecedor/app/models/provider_service_model.dart';
import 'package:cuidapet_fornecedor/app/models/schedule_model.dart';
import 'package:cuidapet_fornecedor/app/shared/components/cuidapet_textformfield.dart';
import 'package:cuidapet_fornecedor/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:intl/intl.dart';
import 'schedule_controller.dart';

class SchedulePage extends StatefulWidget {
  final ScheduleModel schedule;
  const SchedulePage({Key key, @required this.schedule}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState
    extends ModularState<SchedulePage, ScheduleController> {
  @override
  void initState() {
    super.initState();
  }

  var dateFormat = DateFormat('dd/MM/yyyy');

  Map<String, dynamic> scheduleStatus = {
    'P': {
      'name': 'Pendente',
      'color': Colors.grey,
    },
    'CN': {
      'icon': Icons.done_sharp,
      'name': 'Confirmado',
      'color': ThemeUtils.primaryColor,
    },
    'F': {
      'icon': Icons.done_all_outlined,
      'name': 'Finalizado',
      'color': Colors.grey[700],
    },
    'C': {
      'icon': Icons.cancel_sharp,
      'name': 'Cancelado',
      'color': Colors.red[400],
    },
  };

  var status = {
    'P': 'Pendente',
    'CN': 'Confirmado',
    'F': 'Finalizado',
    'C': 'Cancelado',
  };
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalhes do agendamento',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                // color: ThemeUtils.primaryColorLight,
                child: Column(
                  children: [
                    CuidapetTextFormField(
                      label: 'Nome do Pet',
                      initialValue: widget.schedule.nomePet,
                      readOnly: true,
                    ),
                    SizedBox(height: 15),
                    CuidapetTextFormField(
                      label: 'Nome do responsável',
                      initialValue: widget.schedule.nome,
                      readOnly: true,
                    ),
                    SizedBox(height: 15),
                    CuidapetTextFormField(
                      label: 'Data de agendamento',
                      initialValue:
                          dateFormat.format(widget.schedule.dataAgendamento),
                      readOnly: true,
                    ),
                    SizedBox(height: 15),
                    CuidapetTextFormField(
                      label: 'Status',
                      color: scheduleStatus[widget.schedule.status]['color'],
                      fontWeight: FontWeight.bold,
                      initialValue: scheduleStatus[widget.schedule.status]
                          ['name'],
                      readOnly: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              _buildServices(),
              InkWell(
                onTap: () => controller.getScheduleChat(widget.schedule.id),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat_outlined, size: 23),
                      SizedBox(width: 5),
                      Text(
                        'Entre em contato',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 1,
                color: ThemeUtils.primaryColor,
              ),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    switch (widget.schedule.status) {
      case 'P':
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: ScreenUtil.screenWidthDp * 0.45,
              height: 60,
              child: RaisedButton(
                color: ThemeUtils.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () =>
                    {controller.changeScheduleStatus('CN', widget.schedule.id)},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.done_sharp, size: 20, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      'Confirmar',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: ScreenUtil.screenWidthDp * 0.45,
              height: 60,
              child: RaisedButton(
                color: Colors.red[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () =>
                    {controller.changeScheduleStatus('C', widget.schedule.id)},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cancel_outlined, size: 20, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      'Cancelar',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      case 'CN':
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: ScreenUtil.screenWidthDp * 0.45,
              height: 60,
              child: RaisedButton(
                color: Colors.grey[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () =>
                    {controller.changeScheduleStatus('F', widget.schedule.id)},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.done_sharp, size: 20, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      'Finalizar',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: ScreenUtil.screenWidthDp * 0.45,
              height: 60,
              child: RaisedButton(
                color: Colors.red[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () =>
                    {controller.changeScheduleStatus('C', widget.schedule.id)},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cancel_outlined, size: 20, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      'Cancelar',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      case 'F':
        return Container();
      case 'C':
        return Container();
      default:
        return Container();
    }
  }

  Widget _buildServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Serviços escolhidos: ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Divider(
          thickness: 1,
          color: ThemeUtils.primaryColor,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: widget.schedule.servicos.length,
            itemBuilder: (_, index) {
              var s = widget.schedule.servicos[index];
              return ListTile(
                leading: CircleAvatar(child: Icon(Icons.pets)),
                title: Text(s.nome),
              );
            }),
        Divider(
          thickness: 1,
          color: ThemeUtils.primaryColor,
        ),
      ],
    );
  }
}
