import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradutaionproject/layouts/homelayout/home_layout.dart';
import 'package:gradutaionproject/modules/DocAppoientment/AdminAppoientment_Screen.dart';
import 'package:gradutaionproject/modules/login/login.dart';
import 'package:gradutaionproject/shared/constant/constant.dart';
import 'package:gradutaionproject/shared/network/local/cache_helper.dart';
import 'package:hexcolor/hexcolor.dart';

import '../register/cubit/register_States.dart';
import '../register/cubit/register_cubit.dart';

class PickDoctorImageScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<RegisterCubit,registerStates>(
      listener: (context,state)
      {
        if(state is UploadImageSucssesState)
        {
          navigatToAndFinish(
              context,
              Login_Screen()
          //  Home_Layout()
          );
        }
      },
      builder:(context,state)=> SafeArea(
        child: Scaffold(
  //   appBar: AppBar(
  //     title: Text(
  //       'PickImage'
  //     ),
  // ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: height,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 250,
                      width: 250,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 200,
                            backgroundImage: RegisterCubit.get(context).pickedImage ==null ?AssetImage('assets/images/user.png') as ImageProvider :FileImage(RegisterCubit.get(context).pickedImage!),
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor:Colors.white,
                                ),
                                CircleAvatar(
                                  radius: 29,
                                  backgroundColor:HexColor(
                                      backgroundColor
                                  ).withBlue(100),
                                  child: IconButton(
                                    color: Colors.white,
                                      onPressed: ()
                                      {
                                        RegisterCubit.get(context).pickImages();
                                      },
                                      icon: Icon(
                                        Icons.camera_alt_outlined
                                      )
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 30
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: deepColor,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: TextButton(
                        onPressed: ()
                        {
                          if(RegisterCubit.get(context).pickedImage!=null)
                          RegisterCubit.get(context).uploadImage('doctors',true);
                        },
                        child: Text(
                          'Upload',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 25
                          ),
                        ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
