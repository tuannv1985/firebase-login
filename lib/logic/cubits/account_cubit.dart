import 'dart:async';

import 'package:firebase_login_tuan2/core/enums/status_state.dart';
import 'package:firebase_login_tuan2/core/models/user_model.dart';
import 'package:firebase_login_tuan2/logic/authrepository.dart';
import 'package:firebase_login_tuan2/logic/states/account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountCubit extends Cubit<AccountState>{
  // final AuthRepository? _authRepository;
  AccountCubit():
        super(AuthRepository.currentUser.isNotEmpty ?
      AccountState(userModel: AuthRepository.currentUser, status: StatusState.success) :
          AccountState(userModel: UserModel.empty, status: StatusState.init));
  void accountSuccess() async{
    if(AuthRepository.currentUser.isNotEmpty){
      //AuthRepository().streamUser();
      AuthRepository().streamAccount().listen((event){
          emit(state.copyWith(userModel: AuthRepository.currentUser, status: StatusState.success, errorMessage: ''));
      });
    } else {
      emit(state.copyWith(userModel: const UserModel(id: ''), status: StatusState.init, errorMessage: ''));
    }
  }
  void accountLogOut() async{
    await Future<void>.delayed(const Duration(seconds: 5), (){
      unawaited(AuthRepository().signOut());
    });
    emit(state.copyWith(status: StatusState.init, errorMessage: ''));
  }
}