import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
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

class Admin_Appoientment_Screen extends StatelessWidget {
  String? clinic;
  Admin_Appoientment_Screen({this.clinic});
  @override
  Widget build(BuildContext context) {
    globalClinic=clinic;
    return BlocProvider(
      create: (context)=>Doctor_Cubit()..getAdminAppoientments(clinic),
      child: Builder(
        builder:(context)
        {
          return BlocConsumer<Doctor_Cubit,Doctor_States>(
            listener: (context,state){     },
            builder:(context,state)=> Scaffold(
              appBar: AppBar(
                title: Text(clinic!),
                actions: [
                  IconButton(
                    onPressed: (){
                      Doctor_Cubit.get(context).getAdminAppoientments(clinic);
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
                  itemBuilder:(context,index)=>AppModel(context,Doctor_Cubit.get(context).appointmentsAdmin[index],state) ,
                  separatorBuilder:(context,index)=> Divider(

                  ),
                  itemCount: Doctor_Cubit.get(context).appointmentsAdmin.length),
            ),
          );
        },
      ),
    );
  }
  Widget AppModel(context,PatientModel model,state)
  {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            '${model.image}',
            height: 50,
            width: 50,
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
          Expanded(
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.green,
              child: ConditionalBuilder(
                condition: state is ActiveAppoientmentLoadingState,
                builder: (context)=>CircularProgressIndicator(
                  color: Colors.white,
                ),
                fallback:(context)=> InkWell(
                  onTap:(){
                    Doctor_Cubit.get(context).ActiveBooking(model,clinic!);
                  } ,
                  child: Text(
                    'Active',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.red,
              child: ConditionalBuilder(
                condition: state is ClearAppoientmentLoadingState,
                builder: (context)=>CircularProgressIndicator(
                  color: Colors.white,
                ),
                fallback:(context)=> InkWell(
                  onLongPress:(){
                    Doctor_Cubit.get(context).clearBooking(model,
                        Clinic: clinic!);
                  } ,
                  child: Text(
                    'Clear',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
