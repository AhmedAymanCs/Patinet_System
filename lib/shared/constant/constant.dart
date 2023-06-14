import 'package:flutter/material.dart';


String backgroundColor='#00989D';
String? globalClinic;
Color deepColor= Colors.deepOrange;
String? docUID;
bool? registered =false;
void navigatTo(context ,Widget)
{
  Navigator.push(context, MaterialPageRoute(builder:(context)=> Widget));
}

void navigatToAndFinish(context ,Widget)
{
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=> Widget),(route) => false,);
}