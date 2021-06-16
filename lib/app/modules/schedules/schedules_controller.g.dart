// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedules_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SchedulesController on _SchedulesControllerBase, Store {
  final _$schedulesFutureAtom =
      Atom(name: '_SchedulesControllerBase.schedulesFuture');

  @override
  ObservableFuture<List<ScheduleModel>> get schedulesFuture {
    _$schedulesFutureAtom.reportRead();
    return super.schedulesFuture;
  }

  @override
  set schedulesFuture(ObservableFuture<List<ScheduleModel>> value) {
    _$schedulesFutureAtom.reportWrite(value, super.schedulesFuture, () {
      super.schedulesFuture = value;
    });
  }

  final _$selectedStatusFilterAtom =
      Atom(name: '_SchedulesControllerBase.selectedStatusFilter');

  @override
  String get selectedStatusFilter {
    _$selectedStatusFilterAtom.reportRead();
    return super.selectedStatusFilter;
  }

  @override
  set selectedStatusFilter(String value) {
    _$selectedStatusFilterAtom.reportWrite(value, super.selectedStatusFilter,
        () {
      super.selectedStatusFilter = value;
    });
  }

  final _$initPageAsyncAction =
      AsyncAction('_SchedulesControllerBase.initPage');

  @override
  Future<void> initPage() {
    return _$initPageAsyncAction.run(() => super.initPage());
  }

  final _$getSchedulesAsyncAction =
      AsyncAction('_SchedulesControllerBase.getSchedules');

  @override
  Future<void> getSchedules() {
    return _$getSchedulesAsyncAction.run(() => super.getSchedules());
  }

  final _$_SchedulesControllerBaseActionController =
      ActionController(name: '_SchedulesControllerBase');

  @override
  void filterBySchedulesStatus(String status) {
    final _$actionInfo = _$_SchedulesControllerBaseActionController.startAction(
        name: '_SchedulesControllerBase.filterBySchedulesStatus');
    try {
      return super.filterBySchedulesStatus(status);
    } finally {
      _$_SchedulesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
schedulesFuture: ${schedulesFuture},
selectedStatusFilter: ${selectedStatusFilter}
    ''';
  }
}
