import 'package:flutter/material.dart';

class WidgetShowDialog {
  static void customShowDialog(BuildContext context, {String? text, Widget? icon}) {
    showDialog(
        context: context,
        builder: (_){
          return AlertDialog(
            actions: [
              SizedBox(
                height: 150,
               // width: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      icon ?? const CircularProgressIndicator(),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(text ?? 'Uploading'),
                    ],
                  ),
                ),
              )
            ],
          );
        }
    );
  }
}