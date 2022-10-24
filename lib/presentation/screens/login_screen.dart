import 'package:firebase_login_tuan2/core/widgets/widget_dialog.dart';
import 'package:firebase_login_tuan2/core/widgets/widget_snackbar.dart';
import 'package:firebase_login_tuan2/logic/cubits/signin_cubit.dart';
import 'package:firebase_login_tuan2/logic/states/signin_state.dart';
import 'package:firebase_login_tuan2/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) async {
        if (state.errorMessage != '') {
          if (state.errorMessage.contains('Error')) {
            WidgetSnackBar.customSnackBar(
                context: context, text: state.errorMessage);
          } else if (state.errorMessage == 'Loading') {
            WidgetShowDialog.customShowDialog(
                context, text: state.errorMessage);
          } else if (state.errorMessage == 'SignIn success') {
            WidgetShowDialog.customShowDialog(
                context, text: state.errorMessage,
                icon: const Icon(
                  Icons.check_circle_rounded, color: Colors.green, size: 20,)
            );
            await Future<void>.delayed(const Duration(seconds: 3), () async {
              Navigator.of(context).pushNamed('/');
              // var result = await Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            }
            );
          } else {
            WidgetShowDialog.customShowDialog(
                context, text: state.errorMessage,
                icon: const Icon(Icons.error, color: Colors.red, size: 20,));
          }
        }
      },
      child: LoginPage(),
    );
  }
}
