import 'package:firebase_login_tuan2/core/models/user_model.dart';
import 'package:firebase_login_tuan2/logic/cubits/account_cubit.dart';
import 'package:firebase_login_tuan2/logic/states/account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<AccountCubit, AccountState>(
          builder: (context, state) {
            final UserModel userModel = UserModel();
            return Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 30, bottom: 50),
                    height: 200,
                    width: 200,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueGrey
                    ),
                    child: const Text('Image', style: TextStyle(fontSize: 30),),
                  ),
                ),
                //const SizedBox(height: 30,),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  color: Colors.black12,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 20,
                        child: Icon(Icons.person, size: 30,),
                      ),
                      SizedBox(width: 25,),
                      Text('${userModel.name!}', style: TextStyle(fontSize: 18),)
                    ],
                  ),
                ),
                const SizedBox(height: 30,),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  color: Colors.black12,
                  child: Row(
                    children: [
                      Icon(Icons.email, size: 40, color: Colors.blueAccent,),
                      SizedBox(width: 25,),
                      Text('${userModel.email!}', style: TextStyle(fontSize: 18),)
                    ],
                  ),
                ),
                const SizedBox(height: 30,),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  color: Colors.black12,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.messenger, size: 40, color: Colors.tealAccent,),
                      SizedBox(width: 25,),
                      Text('message', style: TextStyle(fontSize: 18),)
                    ],
                  ),
                ),
                const SizedBox(height: 30,),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  color: Colors.black12,
                  child: Row(
                    children: [
                      Icon(Icons.phone, size: 40, color: Colors.yellowAccent,),
                      SizedBox(width: 25,),
                      Text('${userModel.phone!.toString()}', style: TextStyle(fontSize: 18),)
                    ],
                  ),
                ),
                const SizedBox(height: 30,),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  color: Colors.black12,
                  child: Row(
                    children: [
                      IconButton(
                          color: Colors.red,
                          onPressed: () {
                            context.read<AccountCubit>().accountLogOut();
                          },
                          icon: Icon(Icons.logout)
                      ),
                      SizedBox(width: 15,),
                      Text('SignOut', style: TextStyle(fontSize: 18),)
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
