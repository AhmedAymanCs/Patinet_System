import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradutaionproject/layouts/cubit/states.dart';

import '../../layouts/cubit/cubit.dart';
import '../../shared/constant/constant.dart';
import 'editProfile_Screen.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder:(context,state)
      {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Container(
                      height: 200,
                      margin: EdgeInsets.all(20),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 100,
                          ),
                          CircleAvatar(
                            radius: 98,
                            backgroundImage: AppCubit.get(context).model!.image ==null ?
                            AssetImage('assets/images/user.png') as ImageProvider
                                :NetworkImage(
                                    '${AppCubit.get(context).model!.image}'
                                  ,
                                ) ,
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomListProfile(
                    context,
                    itemName: 'Name',
                    item: AppCubit.get(context).model!.name
                  ),
                  CustomListProfile(
                    context,
                    itemName: 'Email',
                    item: AppCubit.get(context).model!.email
                  ),
                  CustomListProfile(
                    context,
                    itemName: 'Phone',
                    item: AppCubit.get(context).model!.phone
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 15,
                      vertical: 15
                    ),
                    child: Text(
                      'Medical History : ${AppCubit.get(context).model!.history}',
                       style:Theme.of(context).textTheme.bodyLarge ,
                    ),
                  ),
                  CustomListProfile(
                      context,
                      itemName: 'BloodGroup',
                      item: AppCubit.get(context).model!.BloodGroup
                  ),
                  CustomListProfile(
                      context,
                      itemName: 'BirthDate',
                      item: AppCubit.get(context).model!.birthdate
                  ),
                  CustomListProfile(
                      context,
                      itemName: 'Gender',
                      item: AppCubit.get(context).model!.gender
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
                            navigatTo(context,editProfile_Screen(
                              email:AppCubit.get(context).model!.email ,
                              blood: AppCubit.get(context).model!.BloodGroup,
                              date: AppCubit.get(context).model!.birthdate,
                              name: AppCubit.get(context).model!.name,
                              phone: AppCubit.get(context).model!.phone,
                              gender: AppCubit.get(context).model!.gender,

                            ) );
                          },
                          child: Text(
                            'EditProfile',
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
      },
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
