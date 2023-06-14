import 'package:flutter/material.dart';
import 'package:gradutaionproject/models/patientModel/patientModel.dart';
import 'package:gradutaionproject/modules/prescription/prescription_writing.dart';
import 'package:gradutaionproject/shared/constant/constant.dart';

class Prescription extends StatelessWidget {

  PatientModel? Model;
   Prescription(this.Model);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomListProfile(
                  context,
                  itemName: 'Name',
                  item: Model!.name
              ),
              CustomListProfile(
                  context,
                  itemName: 'Email',
                  item: Model!.email
              ),
              CustomListProfile(
                  context,
                  itemName: 'Age',
                  item: Model!.age.toString()
              ),
              Padding(
                padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 15,
                    vertical: 15
                ),
                child: Text(
                  'Medical History : ${Model!.history}',
                  style:Theme.of(context).textTheme.bodyLarge ,
                ),
              ),
              CustomListProfile(
                  context,
                  itemName: 'BloodGroup',
                  item: Model!.BloodGroup
              ),
              CustomListProfile(
                  context,
                  itemName: 'BirthDate',
                  item: Model!.birthdate
              ),
              CustomListProfile(
                  context,
                  itemName: 'Gender',
                  item: Model!.gender
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Container(
                  width: 150,
                  margin: EdgeInsetsDirectional.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.deepOrange
                  ),
                  child: TextButton(
                      onPressed: (){
                        navigatTo(context, prescriptionWriting_Screen(Model));
                      },
                      child: Text(
                        'Write Prescription',
                        style:Theme.of(context).textTheme.bodyLarge ,
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CustomListProfile(context,{
    String? item,
    String? itemName,
  }) {
    return ListTile(
      enabled: false,
      leading: Container(

        child: Text(
          '$itemName : ',
          style:Theme.of(context).textTheme.bodyLarge ,
        ),
      ),
      title: Text(
        '$item',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 15
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,

      ),
    );
  }
}
