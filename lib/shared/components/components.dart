import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Widget defaultTextFormField(
    {
      @ required TextEditingController? controller,
      double radius =15,
      IconData? preicon,
      IconData? suficon,
      String? label,
      VoidCallback? sufixOnPressed,
      Function(String?)? onChanged,
      Function(String?)? onSubmited,
      String? Function(String?)? validate,
      bool isSecure=false,
      TextInputType? type
    }
    )
{
  return TextFormField(
    obscureText: isSecure,
    controller:controller ,
    keyboardType: type,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      prefixIcon: Icon(preicon),
      suffixIcon: IconButton(
          onPressed: sufixOnPressed,
          icon: Icon(suficon)),
      labelText: label,
    ),
    onChanged: onChanged,
    onFieldSubmitted: onSubmited,
    validator: validate,
  );
}

Widget doctorModel(context,{
  required String? name,
  required String? specification,
  required String? start,
  required String? end,
  required String? imageUrl,
  Color? color,
})
{
  int time1= int.parse(start!.substring(0,2));
  int time2= int.parse(end!.substring(0,2));
  int now =DateTime.now().hour;
  bool avilable = false;
  if(now>=time1&&now<=time2)
  {
    avilable=true;
  }
  return Container(
    height: 100,
    width: double.infinity,
    margin: EdgeInsets.all(10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Image.network(
          imageUrl!,
          height: 100,
          width: 100,
          fit: BoxFit.contain,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$name',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$specification',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Start : $start',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: color==null ? avilable ? Colors.green: Colors.grey : Colors.green
                        ),
                      ),
                      Text(
                        'End : $end',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: color==null ? avilable ? Colors.green: Colors.grey : Colors.green
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
        // Center(
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child:
        //   ),
        // ),
      ],
    ),
  );
}