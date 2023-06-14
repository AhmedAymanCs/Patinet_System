import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradutaionproject/layouts/cubit/cubit.dart';
import 'package:gradutaionproject/layouts/cubit/states.dart';
import 'package:gradutaionproject/models/patientModel/patientModel.dart';
import 'package:hexcolor/hexcolor.dart';

class Appoientments_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context)
            {
              AppCubit.get(context).getAppoientments();
              return BlocConsumer<AppCubit,AppStates>(
                listener: (context,state)
                {
                  if(state is delBookingSucssesState)
                  {
                    Fluttertoast.showToast
                      (
                        msg:'Canceled Appointment',
                        backgroundColor: Colors.green
                    );
                  }
                },
                builder:(context,state)=> ConditionalBuilder(
                  condition: state is delBookingSucssesState,
                  builder: (context)=>Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepOrange,
                    ),
                  ),
                  fallback:(context)=> Scaffold(
                    body:ListView.separated(
                        itemBuilder: (context,index)=>AppModel(context,AppCubit.get(context).appointments[index]),
                        separatorBuilder: (context,index)=>Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.white,
                        ),
                        itemCount: AppCubit.get(context).appointments.length
                    ) ,
                  ),
                ),
              );
            }
    );
  }

  Widget AppModel(context,PatientAppoinementsModel model)
  {
    return Container(
      height: 180,
      width: double.infinity,
      margin: EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.network(
            '${model.imageUrl}',
            height: 180,
            width: 120,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${model.name}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${model.specification}',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Booking time:${model.timeOfBooking}',
                  style: Theme.of(context).textTheme.bodyLarge!
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    model.isActive!? 'Activated':'Pending..please pay to Activate',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 10,
                      color:model.isActive!? Colors.lightGreenAccent: Colors.yellowAccent
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'End : ${model.endTime}',
                  style: Theme.of(context).textTheme.bodyLarge!
                ),
              ),

            ],
          ),
          Expanded(
            child: IconButton
              (
                onPressed: (){
                  AppCubit.get(context).CancelBooking(model);
                },
                icon: Icon(
                  Icons.cancel,
                  color: Colors.red.withOpacity(.8),
                )),
          )
        ],
      ),
    );
  }
}
