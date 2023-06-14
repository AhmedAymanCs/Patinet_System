import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradutaionproject/layouts/cubit/cubit.dart';
import 'package:gradutaionproject/layouts/cubit/states.dart';
import 'package:gradutaionproject/modules/booking/Booking_Screen.dart';
import 'package:gradutaionproject/shared/constant/constant.dart';

import '../../models/doctorModel/doctorModel.dart';

class Doctor_Module extends StatelessWidget {

  Doctor_Module(this.model,this.appBarName);
  List<DoctorModel> model=[];
  String? appBarName;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder:(context,state)=> Scaffold(
        appBar: AppBar(
          title: Text(appBarName!),
        ),
        body: ConditionalBuilder(
          builder: (context)=>Center(
            child: CircularProgressIndicator(
              color: deepColor,
            ),
          ),
          fallback: (context)=>ListView.separated(
              itemBuilder: (context,index)=>doctorModel(context,model[index])
              , separatorBuilder:(context,index)=> Container(
                width: double.infinity,
                height: 1,
                color: Colors.white,
              )
              , itemCount: model.length,
          ), condition: state is GetDoctorDataLoadingState,
        ),
      ),
    );
  }

  Widget doctorModel(context,DoctorModel model)
  {
 int time1= int.parse(model.startTime!.substring(0,2));
 int time2= int.parse(model.endTime!.substring(0,2));
 int now =DateTime.now().hour;
 String endTime='';
 String startTime='';
 bool avilable = false;
 if(time2 > 12)
 {
   endTime=model.endTime!.replaceRange(0, 2, '${time2-12} ')+' PM';
 }
 else
 {
   endTime=model.endTime! + ' AM';
 }
 if(time1 > 12)
 {
   startTime=model.startTime!.replaceRange(0, 2, '${time1-12} ')+' PM';
 }
 else
 {
   startTime=model.startTime! + ' AM';
 }

 print(' start : $time1   end : $time2');
 print(now);

 if(now>12)
   {
     if(now>=time1&&now<time2)
     {
       avilable=true;
     }
   }
 else
   {
     if(now<=time1&&now>=time2-12)
     {
       avilable=true;
     }
   }



    return InkWell(
      onTap: ()
      {
        if(avilable)
          {
            navigatTo(context, Booking_Screen(model,startTime,endTime));
          }
      },
      child: Container(
        height: 100,
        width: double.infinity,
        margin: EdgeInsets.all(10),
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
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${model.name}',
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
                          '${model.specification}',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Start : $startTime',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: avilable ? Colors.green: Colors.grey
                            ),
                          ),
                          Text(
                            'End : $endTime',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: avilable ? Colors.green: Colors.grey
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
      ),
    );
  }

}
