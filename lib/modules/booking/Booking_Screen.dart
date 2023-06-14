import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradutaionproject/layouts/cubit/cubit.dart';
import 'package:gradutaionproject/layouts/cubit/states.dart';
import 'package:gradutaionproject/layouts/homelayout/home_layout.dart';

import '../../models/doctorModel/doctorModel.dart';
import '../../shared/components/components.dart';
import '../../shared/constant/constant.dart';

class Booking_Screen extends StatelessWidget {
  Booking_Screen(this.bookingModel,this.startTime,this.endTime);
  DoctorModel bookingModel;
  String endTime='';
  String startTime='';
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){
          if(state is BookingSucssesState)
            {
              Fluttertoast.showToast(
                  msg:'Booking Success',
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.green
              ).then(
                  (value)
                  {
                    navigatToAndFinish(context, Home_Layout());
                  }
              );
            }
        },
        builder:(context,state)=> Scaffold(
          appBar: AppBar(),
          body:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              doctorModel(context,
                name: bookingModel.name,
                specification: bookingModel.specification
                , start: startTime,
                end: endTime,
                imageUrl: bookingModel.image,
                color: Colors.green
              ),
              Spacer(),
              Container(
                margin: EdgeInsetsDirectional.all(25),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: ConditionalBuilder(
                  condition: state is BookingLoadingState,
                  builder: (context)=>Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  fallback:(context)=> TextButton(
                      onPressed: (){
                      AppCubit.get(context).Booking(context,bookingModel);
                      }
                      , child: Text(
                      'Booking Now',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                  ),
                ),
              )
            ],
          ),
        ),
      )
    ;
  }
}
