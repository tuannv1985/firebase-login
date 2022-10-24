import 'package:equatable/equatable.dart';
import 'package:firebase_login_tuan2/core/enums/status_state.dart';
import 'package:firebase_login_tuan2/core/models/user_model.dart';

class AccountState extends Equatable{
  final UserModel? userModel;
  final StatusState? status;
  final String? errorMessage;

  const AccountState({this.userModel, this.status, this.errorMessage});
  @override
  List<Object?> get props => [userModel, status, errorMessage];
  AccountState copyWith({UserModel? userModel, StatusState? status, String? errorMessage}){
    return AccountState(
      userModel: userModel ?? this.userModel,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}