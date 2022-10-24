
import 'package:firebase_login_tuan2/core/widgets/widget_dialog.dart';
import 'package:firebase_login_tuan2/core/widgets/widget_elevatedbutton.dart';
import 'package:firebase_login_tuan2/core/widgets/widget_snackbar.dart';
import 'package:firebase_login_tuan2/logic/authrepository.dart';
import 'package:firebase_login_tuan2/logic/cubits/signin_cubit.dart';
import 'package:firebase_login_tuan2/logic/states/signin_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final AuthRepository _authRepository = AuthRepository();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                onSaved: (value) => emailController.text = value!,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  label: Text('enter email')
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                onSaved: (value) => passwordController.text = value!,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.key),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  label: const Text('enter password'),
                  suffixIcon: IconButton(
                      onPressed: (){
                        setState((){
                          isVisible = !isVisible;
                        });
                      },
                      icon: isVisible ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility)
                  )
                ),
                obscureText: isVisible,
              ),
              const SizedBox(height: 20),

              CustomElevatedButton(
                  onPressed: (){
                    context.read<SignInCubit>().signInWithCredentials(
                        email: emailController.text,
                        password: passwordController.text
                    );
                  },
                  color: Colors.blueAccent,
                  child: const Text('Login'),
                ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: (){
                  Navigator.of(context).pushNamed('/signup');
                },
                color: Colors.greenAccent,
                child: const Text('SignUp'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
