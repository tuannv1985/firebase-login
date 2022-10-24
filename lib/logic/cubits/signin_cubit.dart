
import 'package:firebase_login_tuan2/core/enums/status_state.dart';
import 'package:firebase_login_tuan2/core/models/user_model.dart';
import 'package:firebase_login_tuan2/logic/authrepository.dart';
import 'package:firebase_login_tuan2/logic/states/signin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository _authRepository;
  SignInCubit({required AuthRepository authRepository}):
        _authRepository = authRepository, super(const SignInState());
  void signInWithCredentials({required String email, required String password}) async{
    emit(state.copyWith(errorMessage: ''));
    if(email.isEmpty){
      emit(state.copyWith(errorMessage: 'Error: Email empty'));
    } else if(!email.isValidEmail()){
      emit(state.copyWith(errorMessage: 'Error: Email isValid'));
    } else if(password.isEmpty){
      emit(state.copyWith(errorMessage: 'Error: Password empty'));
    } else if(password.length < 6){
      emit(state.copyWith(errorMessage: 'Error: Password isValid'));
    } else {
      emit(state.copyWith(errorMessage: 'Loading', status: StatusState.loading));
      String statusSignIn = await _authRepository.signIn(email: email, password: password);
      _authRepository.streamUser();
        // var data = UserModel(id: "id");
        // AuthRepository.currentUser = data;
      if(statusSignIn == 'SignIn success'){
        emit(state.copyWith(errorMessage: statusSignIn, status: StatusState.success));
      } else {
        emit(state.copyWith(errorMessage: statusSignIn, status: StatusState.error));
      }
    }
  }
}

extension ValidEmail on String{
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}