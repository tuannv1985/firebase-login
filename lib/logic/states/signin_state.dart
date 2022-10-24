import 'package:equatable/equatable.dart';
import 'package:firebase_login_tuan2/core/enums/status_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInState extends Equatable{
  final String errorMessage;
  final StatusState status;

  const SignInState({this.errorMessage = '', this.status = StatusState.init});
  @override
  List<Object?> get props => [errorMessage, status];
  SignInState copyWith({String? errorMessage, StatusState? status}){
    return SignInState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status
    );
  }
}