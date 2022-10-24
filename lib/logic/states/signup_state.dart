import 'package:equatable/equatable.dart';
import 'package:firebase_login_tuan2/core/enums/status_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpState extends Equatable{
  final String errorMessage;
  final StatusState status;

  const SignUpState({this.errorMessage = '', this.status = StatusState.init});
  @override
  List<Object?> get props => [errorMessage, status];
  SignUpState copyWith({String? errorMessage, StatusState? status}){
    return SignUpState(
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status
    );
  }
}