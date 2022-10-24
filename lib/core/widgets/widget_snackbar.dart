import 'package:firebase_login_tuan2/core/widgets/widget_elevatedbutton.dart';
import 'package:flutter/material.dart';

class WidgetSnackBar{
  static void customSnackBar({required BuildContext context, String? text}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        backgroundColor: Colors.orangeAccent,
        duration: const Duration(seconds: 5),
        content: SizedBox(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 20,),
              const SizedBox(height: 10,),
              Text(text ?? 'No success')
            ],
          ),
        )
      )
    );
  }
}