import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {

  HomeCubit() : super(HomeState(type: HomeType.voucher));

  Future<bool> selectItem(HomeType type) async {
    emit(state.copyWith(type: type));
    return true;
  }
}