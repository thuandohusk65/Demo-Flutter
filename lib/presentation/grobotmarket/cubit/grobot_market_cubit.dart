import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/data/repository/app_repository.dart';
import 'package:flutter_project/models/Grobot.dart';
import 'grobot_market_state.dart';

class GrobotMarketCubit extends Cubit<GrobotMarketState> {
  GrobotMarketCubit() : super(GrobotMarketState.initial) {
    getGrobotMarket();
  }
  List<Data>? listGrobot = null;

  Future<void> getGrobotMarket() async {
    print('join in get grobot');
    emit(GrobotMarketState.loading);
    try {
      listGrobot = await AppRepository().getGrobotMarket();
      emit(GrobotMarketState.success);
    } catch (e) {
      emit(GrobotMarketState.failure);
    }
  }
}
