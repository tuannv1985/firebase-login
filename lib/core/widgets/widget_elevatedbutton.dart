
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget{
  final VoidCallback onPressed;
  final Widget child;
  final Color? color;

  CustomElevatedButton({required this.onPressed, required this.child, this.color});

  @override
  Widget build(BuildContext context) {
   return SizedBox(
     height: 45,
     width: 200,
     child: ElevatedButton(
       onPressed: onPressed,
       child: child,
       style: ElevatedButton.styleFrom(
         primary: color,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(10)
         )
       ),
     ),
   );
  }
}