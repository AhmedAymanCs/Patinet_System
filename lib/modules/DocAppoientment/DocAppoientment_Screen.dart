import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradutaionproject/layouts/cubit/cubit.dart';
import 'package:gradutaionproject/layouts/cubit/states.dart';
import 'package:gradutaionproject/models/patientModel/patientModel.dart';
import 'package:gradutaionproject/modules/DocAppoientment/cubit/doc_cubit.dart';
import 'package:gradutaionproject/modules/DocAppoientment/cubit/states.dart';
import 'package:gradutaionproject/modules/login/login.dart';
import 'package:gradutaionproject/modules/prescription/prescription_Screen.dart';
import 'package:gradutaionproject/shared/constant/constant.dart';
import 'package:gradutaionproject/shared/network/local/cache_helper.dart';

class Doc_Appoientment_Screen extends StatelessWidget {
  String? clinic;
  Doc_Appoientment_Screen({this.clinic});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>Doctor_Cubit(),
      child: Builder(
          builder:(context)
          {
           Doctor_Cubit.get(context).getDocAppoientments(clinic);
            return  BlocConsumer<Doctor_Cubit,Doctor_States>(
              listener: (context,state){},
              builder:(context,state)=> Scaffold(
                appBar: AppBar(
                  title: Text('Appopintment'),
                  actions: [
                    IconButton(
                      onPressed: (){
                        Doctor_Cubit.get(context).getDocAppoientments(clinic);
                      },
                      icon: Icon(
                          Icons.refresh
                      ),
                    ),
                    TextButton(
                        onPressed: (){
                          CacheHelper.removedata('uId').then(
                                  (value)
                              {
                                navigatToAndFinish(context, Login_Screen());

                              }
                          );
                        },
                        child: Text(
                          'SingOut',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        )),
                  ],
                ),
                body: ListView.separated(
                    itemBuilder:(context,index)=>AppModel(context,Doctor_Cubit.get(context).appointmentsDoctor[index]) ,
                    separatorBuilder:(context,index)=> Divider(
                    ),
                    itemCount: Doctor_Cubit.get(context).appointmentsDoctor.length),
              ),
            );
          }
      ),
    );
  }
  Widget AppModel(context,PatientModel model)
  {
    return InkWell(
      onTap: ()
      {
        navigatTo(context, Prescription(model));
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              '${model.image}',
              height: 100,
              width: 100,
              fit: BoxFit.contain,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${model.name}',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w800
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'BloodGroup: ${model.BloodGroup}',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Age : ${model.age}',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
