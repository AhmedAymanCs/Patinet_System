import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradutaionproject/layouts/cubit/cubit.dart';
import 'package:gradutaionproject/layouts/cubit/states.dart';
import 'package:gradutaionproject/models/patientModel/patientModel.dart';
import 'package:gradutaionproject/modules/DocAppoientment/DocAppoientment_Screen.dart';
import 'package:gradutaionproject/modules/DocAppoientment/cubit/doc_cubit.dart';
import 'package:gradutaionproject/modules/DocAppoientment/cubit/states.dart';
import 'package:gradutaionproject/modules/prescription/prescription_Screen.dart';
import 'package:gradutaionproject/shared/constant/constant.dart';
import 'package:intl/intl.dart';

class prescriptionWriting_Screen extends StatelessWidget {
  PatientModel? Model;
  prescriptionWriting_Screen(this.Model);
  var prescription = TextEditingController();
  String? finalPrescription;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>Doctor_Cubit(),
      child:BlocConsumer<Doctor_Cubit,Doctor_States>(
        listener: (context,state){
          if(state is PutPrescriptionSucssesState)
            {
              Fluttertoast.showToast
                (
                  msg: 'Done',
                toastLength: Toast.LENGTH_SHORT
              ).then
                (
                      (value)
              {
               navigatToAndFinish(context, Doc_Appoientment_Screen(
                 clinic: globalClinic,
               ));

              });
            }
        },
        builder:(context,state)=> Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: ()
                  {
                    var currentDate=DateTime.now().toIso8601String().split('T');
                    String hour;

                    if(TimeOfDay.now().hour>12)
                    {
                      print('${TimeOfDay.now().hour-12} PM');
                      hour='${TimeOfDay.now().hour-12} PM';
                    }
                    else
                      {
                        hour='${TimeOfDay.now().hour} AM';
                      }
                    finalPrescription=( '${Model!.history!}     Prescription of Clinic($globalClinic) ${currentDate[0]+' '+hour+' :'+prescription.text}');
                    Model!.history = finalPrescription;
                    Doctor_Cubit.get(context).putPrescription(Model!);
                  },
                  child: ConditionalBuilder(
                    condition: state is PutPrescriptionLoadingState,
                    builder: (context)=>Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                    fallback:(context)=> Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
               children: [
                 Text(
                 '${Model!.name}',
                   style: Theme.of(context).textTheme.bodyLarge,
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: TextFormField(
                     controller: prescription,
                     maxLines: 30,
                     minLines: 30,
                     decoration:InputDecoration(
                       labelStyle: TextStyle(
                         color: Colors.black54,
                       ),
                       filled: true,
                       fillColor: Colors.white,
                       labelText: 'Prescription' ,
                       border: OutlineInputBorder(),
                     ),
                   ),
                 ),
               ],
            ),
          ),
        ),
      ),
    );
  }
}
