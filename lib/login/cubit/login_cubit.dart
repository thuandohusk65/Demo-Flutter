import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/login/cubit/login_state.dart';
import 'package:flutter_project/login/repository/login_repository.dart';
import 'package:flutter_project/utils/utils.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit(): super(LoginStates.initial);

  Future<void> requestLogin() async {
    emit(LoginStates.loading);
    final userToken = await LoginRepository().getUserInfor();
    if(userToken.accessToken.isNotEmpty) {
      UserUtils.accessToken = userToken.accessToken;
      emit(LoginStates.success);
    } else {
      emit(LoginStates.failure);
    }
  }
}