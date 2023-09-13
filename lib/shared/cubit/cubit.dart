import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_1/shared/cubit/state.dart';
import 'package:shop_app_1/shared/network/local/cash_helper.dart';

class AppCupit extends Cubit<AppStates> {
  AppCupit() : super(AppInitialStates());

  static AppCupit get(context) => BlocProvider.of(context);
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  bool isBottomSheetSown = false;
  IconData fabIcon = Icons.edit;

  changeBottomSheetState({required bool isShow, required IconData icon}) {
    isBottomSheetSown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetStates());
  }

  bool isDark = false;

  void changeDark({bool? formShared}) {
    if (formShared != null) {
      isDark = formShared;
      emit(AppChangeModeStates());
    } else {
      isDark = !isDark;
      CacheHelper.putBool(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeStates());
      });
    }
  }
}

////////////////////////////////////
// Future<void> updateDatabase({
//   required String status,
//   required int? id,
// }) async {
//   if (database == null || id == null) {
//     return;
//   }
//
//   final rowsUpdated = await database!.rawUpdate(
//     'UPDATE tasks SET status = ? WHERE id = ?',
//     ['$status', id],
//   );
//
//   if (rowsUpdated == 1) {
//     emit(AppUpdateDatabaseStates());
//   }
// }
