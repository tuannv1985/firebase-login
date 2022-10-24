import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login_tuan2/core/router/route_app.dart';
import 'package:firebase_login_tuan2/logic/authrepository.dart';
import 'package:firebase_login_tuan2/logic/cubits/account_cubit.dart';
import 'package:firebase_login_tuan2/logic/cubits/signin_cubit.dart';
import 'package:firebase_login_tuan2/logic/cubits/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final AuthRepository user = AuthRepository();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final RouteApp _routeApp = RouteApp();
  final AuthRepository _authRepository = AuthRepository();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //_authRepository.streamUser();
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInCubit>(
        create: (context) => SignInCubit(authRepository: _authRepository),
        ),
        BlocProvider<SignUpCubit>(
          create: (context) => SignUpCubit(authRepository: _authRepository),
        ),
        BlocProvider<AccountCubit>(
        create: (context) => AccountCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter firebase Login',
        onGenerateRoute: _routeApp.onGenerateRoute,
      ),
    );
  }
}