import 'package:cuidapet_fornecedor/app/models/schedule_model.dart';
import 'package:cuidapet_fornecedor/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';

class ScheduleItemList extends StatelessWidget {
  final ScheduleModel _scheduleModel;
  const ScheduleItemList(this._scheduleModel, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> schedulesStatus = {
      'P': {
        'icon': Icons.pending_sharp,
        'name': 'PENDENTE',
        'color': Colors.grey,
      },
      'CN': {
        'icon': Icons.done_sharp,
        'name': 'CONFIRMADO',
        'color': ThemeUtils.primaryColor,
      },
      'F': {
        'icon': Icons.done_all_outlined,
        'name': 'FINALIZADO',
        'color': Colors.grey[700],
      },
      'C': {
        'icon': Icons.cancel_sharp,
        'name': 'CANCELADO',
        'color': Colors.red[400],
      },
    };

    print(_scheduleModel);
    return InkWell(
      onTap: () =>
          {Modular.to.pushNamed('/schedule', arguments: _scheduleModel)},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Stack(
          children: [
            Container(
              height: 88,
              width: ScreenUtil.screenWidthDp,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  border: Border.all(color: ThemeUtils.primaryColor)),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.pets_outlined,
                                color: Colors.grey[500], size: 20),
                            SizedBox(width: 5),
                            Text(_scheduleModel.nomePet,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: ThemeUtils.primaryColorDark)),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: Row(
                            children: [
                              Icon(Icons.person,
                                  color: Colors.grey[500], size: 20),
                              SizedBox(width: 5),
                              Text(
                                _scheduleModel.nome,
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Icon(schedulesStatus[_scheduleModel.status]['icon'],
                      color: schedulesStatus[_scheduleModel.status]['color']),
                  SizedBox(width: 5),
                  Text(
                    schedulesStatus[_scheduleModel.status]['name'],
                    style: TextStyle(
                        color: schedulesStatus[_scheduleModel.status]['color'],
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: CircleAvatar(
                      maxRadius: 15,
                      backgroundColor: ThemeUtils.primaryColorDark,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
