import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/grobotmarket/cubit/grobot_market_state.dart';
import 'package:flutter_project/grobotmarket/repository/grobot_market_repository.dart';
import 'package:flutter_project/models/Grobot.dart';

class GrobotMarketCubit extends Cubit<GrobotMarketState> {
  GrobotMarketCubit() : super(GrobotMarketState.initial) {
    getGrobotMarket();
  }
  List<Data>? listGrobot = null;

  Future<void> getGrobotMarket() async {
    print('join in get grobot');
    emit(GrobotMarketState.loading);
    try {
      listGrobot = await GrobotMarketRepository().getGrobotMarket();
      emit(GrobotMarketState.success);
    } catch (e) {
      emit(GrobotMarketState.failure);
    }
  }
}
