import 'package:firebase_login_tuan2/core/enums/status_state.dart';
import 'package:firebase_login_tuan2/logic/authrepository.dart';
import 'package:firebase_login_tuan2/logic/cubits/account_cubit.dart';
import 'package:firebase_login_tuan2/logic/cubits/signin_cubit.dart';
import 'package:firebase_login_tuan2/logic/cubits/signup_cubit.dart';
import 'package:firebase_login_tuan2/logic/states/account_state.dart';
import 'package:firebase_login_tuan2/logic/states/signin_state.dart';
import 'package:firebase_login_tuan2/presentation/pages/account_page.dart';
import 'package:firebase_login_tuan2/presentation/pages/login_page.dart';
import 'package:firebase_login_tuan2/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountCubit>(
      create: (BuildContext context) => AccountCubit()..accountSuccess(),
      child: BlocBuilder<AccountCubit, AccountState>(
        buildWhen: (previous, current) =>previous.status != current.status,
        builder: (context, state) {
          if(state.status == StatusState.success) {
            return AccountPage();
          }
          else {
            return LogInScreen();

          }
          return Text('no run');
        },
      ),
    );
  }
}
