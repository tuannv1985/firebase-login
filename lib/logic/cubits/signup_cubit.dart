
import 'package:firebase_login_tuan2/core/enums/status_state.dart';
import 'package:firebase_login_tuan2/core/models/user_model.dart';
import 'package:firebase_login_tuan2/logic/authrepository.dart';
import 'package:firebase_login_tuan2/logic/states/signin_state.dart';
import 'package:firebase_login_tuan2/logic/states/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository _authRepository;
  SignUpCubit({required AuthRepository authRepository}):
        _authRepository = authRepository, super(const SignUpState());
  void signUpWithCredentials({required String email, required String password, required String name, required String phone}) async{
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
      String statusSignUp = await _authRepository.signUp(email: email, password: password, name: name, phone: int.parse(phone));
      _authRepository.streamUser();
        // var data = UserModel(id: "id");
        // AuthRepository.currentUser = data;
      if(statusSignUp == "SignUp Success"){
        emit(state.copyWith(errorMessage: statusSignUp, status: StatusState.success));
      } else {
        emit(state.copyWith(errorMessage: statusSignUp, status: StatusState.error));
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