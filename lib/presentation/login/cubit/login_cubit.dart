import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/data/repository/app_repository.dart';
import 'package:flutter_project/utils/utils.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit(): super(LoginStates.initial);

  Future<void> requestLogin(String acc, String pass) async {
    emit(LoginStates.loading);
    final userToken = await AppRepository().getUserToken(acc, pass);
    if(userToken.accessToken.isNotEmpty) {
      UserUtils.accessToken = userToken.accessToken;
      emit(LoginStates.success);
    } else {
      emit(LoginStates.failure);
    }
  }
}