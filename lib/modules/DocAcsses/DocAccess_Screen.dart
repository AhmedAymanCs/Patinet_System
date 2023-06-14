import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradutaionproject/modules/DocAppoientment/DocAppoientment_Screen.dart';
import 'package:gradutaionproject/modules/DocAppoientment/cubit/doc_cubit.dart';
import 'package:gradutaionproject/modules/DocAppoientment/cubit/states.dart';
import 'package:gradutaionproject/modules/adminScreen/adminScreen.dart';
import 'package:gradutaionproject/shared/components/components.dart';
import 'package:gradutaionproject/shared/constant/constant.dart';
import 'package:hexcolor/hexcolor.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class Doc_Acsses extends StatefulWidget {

  @override
  State<Doc_Acsses> createState() => _Doc_AcssesState();
}

class _Doc_AcssesState extends State<Doc_Acsses> {

  String? clinic;

  var passController=TextEditingController();

  var items = [
    'Dentistry',
    'Dermatology',
    'ear',
    'Surgery',
    'Admin',
  ];
  String privatePass='';
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context)=>DocAcssesCubit()..getAcssesInfo(),
      child: BlocConsumer<DocAcssesCubit,DocAcssesStates>(
        listener: (context,state){
        },
        builder: (context,state){
          DocAcssesCubit cubit = DocAcssesCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    color: Colors.white,
                      margin: EdgeInsets.symmetric(
                        vertical: 30
                      ),
                      child: Center(
                          child: Text(
                              'Access'
                                  ,
                            style: TextStyle(
                              color: HexColor(backgroundColor),
                            ),
                          ))
                  ),
                  DropdownButton(
                      value:clinic,
                      items:items.map(
                              (item)
                          {
                            return DropdownMenuItem<String>(
                              child:Text(item),
                              value: item,
                            );
                          }
                      ).toList(),

                      onChanged: (String? value) {
                        setState(() {
                          clinic = value;
                          print('Clinic is  $clinic');
                        });
                      }
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    controller: passController,
                    label: 'Access Password',
                    isSecure: true,
                    radius: 30,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: ()
                      {

                        // else if(passController.text=='12345'&&clinic=='Admin')
                        //   {
                        //     navigatTo(context, Admin_Screen());
                        //   }

                        switch(clinic)
                        {
                          case 'Dentistry': privatePass = cubit.data!.Dentistry!;
                          break;
                          case 'Dermatology': privatePass = cubit.data!.Dermatology!;
                          break;
                          case 'Admin': privatePass = cubit.data!.Admin!;
                          break;
                          case 'ear': privatePass = cubit.data!.Dermatology!;
                          break;
                          case 'Surgery': privatePass = cubit.data!.Surgery!;
                          break;
                        }
                        if(passController.text==privatePass&&clinic!='Admin')
                          {
                            navigatToAndFinish(context, Doc_Appoientment_Screen(clinic: clinic,));
                            globalClinic=clinic;
                          }
                        if((passController.text==privatePass&&clinic=='Admin'))
                          {
                        navigatTo(context, Admin_Screen());
                          }

                      },
                      child:Text(
                          'Accses',
                        style: TextStyle(
                          backgroundColor: Colors.white,
                          color: Colors.deepOrange
                        ),
                      )
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
