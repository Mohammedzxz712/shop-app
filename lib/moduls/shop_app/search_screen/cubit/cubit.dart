import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_1/models/shop_app/search_model.dart';
import 'package:shop_app_1/moduls/shop_app/search_screen/cubit/states.dart';
import 'package:shop_app_1/shared/components/constants.dart';
import 'package:shop_app_1/shared/network/remote/dio_helper.dart';
import 'package:shop_app_1/shared/network/remote/end_points.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialStates());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;

  void searchData(String text) {
    emit(SearchLoadingStates());
    DioHelper.postData(
      url: SEARCH,
      data: {"text": text},
      token: token!,
    ).then((value) {
      searchModel = SearchModel.fromJson(value!.data);
      emit(SearchSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorStates());
    });
  }
}
