import 'package:firebase_login_tuan2/core/widgets/widget_dialog.dart';
import 'package:firebase_login_tuan2/core/widgets/widget_elevatedbutton.dart';
import 'package:firebase_login_tuan2/core/widgets/widget_snackbar.dart';
import 'package:firebase_login_tuan2/logic/authrepository.dart';
import 'package:firebase_login_tuan2/logic/cubits/signin_cubit.dart';
import 'package:firebase_login_tuan2/logic/cubits/signup_cubit.dart';
import 'package:firebase_login_tuan2/logic/states/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isVisible = false;
  final AuthRepository _authRepository = AuthRepository();
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
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: isVisible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility)
                    )
                ),
                obscureText: isVisible,
              ),
              TextFormField(
                controller: nameController,
                onSaved: (value) => nameController.text = value!,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    label: Text('enter name')
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: phoneController,
                onSaved: (value) => phoneController.text = value!,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    label: Text('enter number phone')
                ),
              ),
              const SizedBox(height: 20),
              BlocListener<SignUpCubit, SignUpState>(
                listener: (context, state) async{
                  if(state.errorMessage != ''){
                    if(state.errorMessage.contains('Error')){
                      WidgetSnackBar.customSnackBar(context: context, text: state.errorMessage);
                    } else if(state.errorMessage == 'Loading'){
                        WidgetShowDialog.customShowDialog(context, text: state.errorMessage);
                    } else if(state.errorMessage == "SignUp Success") {
                        await Future<void>.delayed(const Duration(seconds: 1),(){
                          WidgetShowDialog.customShowDialog(
                          context, text: state.errorMessage,
                          icon: const Icon(Icons.check_circle_rounded, color: Colors.green, size: 20,)
                          );
                          Navigator.of(context).pushNamed('/');
                          }
                        );
                    } else {
                        WidgetShowDialog.customShowDialog(
                          context, text: state.errorMessage,
                          icon: const Icon(Icons.error, color: Colors.red, size: 20,));
                    }
                  }
                },
                child: CustomElevatedButton(
                  onPressed: () {
                    context.read<SignUpCubit>().signUpWithCredentials(
                        email: emailController.text,
                        password: passwordController.text,
                        name: nameController.text,
                        phone: phoneController.text
                    );
                    //Navigator.of(context).pop();
                  },
                  color: Colors.greenAccent,
                  child: const Text('SignUp'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
