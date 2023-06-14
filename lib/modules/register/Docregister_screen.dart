import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradutaionproject/modules/login/login.dart';
import 'package:gradutaionproject/modules/pickImageScreen/pickImage_Screen.dart';
import 'package:gradutaionproject/modules/register/cubit/register_States.dart';
import 'package:gradutaionproject/modules/register/cubit/register_cubit.dart';
import 'package:gradutaionproject/shared/constant/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../pickDoctorImageScreen/pickDoctorImage_Screen.dart';

class Doc_Register_Screen extends StatelessWidget
{
  var namecontroller = TextEditingController() ;
  var emailcontroller = TextEditingController() ;
  var startcontroller = TextEditingController() ;
  var endcontroller = TextEditingController() ;
  var cliniccontroller = TextEditingController() ;
  var confirmpasscontroller = TextEditingController() ;
  var specificationcontroller = TextEditingController() ;
  var passwordcontroller = TextEditingController() ;
  var gender ='Male';
  int age=0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit,registerStates>(
      listener: (context,state){
        if(state is DocRegisterSucssesState)
          {
            navigatToAndFinish(
                context,
                PickDoctorImageScreen()
            );
          }
      },
      builder:(context,state)=> Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image(
              image: AssetImage(
                  'assets/images/background.jpg'
              ),
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Text('Sign UP' ,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0 ,
                        fontWeight: FontWeight.bold ,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    //name
                    TextFormField(
                      validator:(value){
                        if(value==null);
                        {
                          return'Name must be not empty';
                        }
                      },
                      controller: namecontroller,
                      decoration:InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Name' ,
                        prefixIcon: Icon(
                          Icons.account_circle_outlined,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    //email
                    TextFormField(
                      validator:(value){
                        if(value==null);
                        {
                          return'Email must be not empty';
                        }
                      },
                      controller: emailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration:InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Email' ,
                        prefixIcon: Icon(
                          Icons.email_outlined ,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    //phone
                    TextFormField(
                      validator:(value){
                        if(value==null)
                        {
                          return'Start Time must be not empty';
                        }
                      },
                      controller: startcontroller,
                      decoration:InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Start Time' ,
                        prefixIcon: Icon(
                          Icons.watch_later_outlined
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    //date
                    TextFormField(
                      validator:(value){
                        if(value==null)
                        {
                          return'End Time must be not empty';
                        }
                      },
                      controller: endcontroller,
                      decoration:InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'End Time' ,
                        prefixIcon: Icon(
                          Icons.lock_clock,
                        ),
                        border: OutlineInputBorder(),

                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    //blood
                    TextFormField(
                      validator:(value){
                        if(value==null);
                        {
                          return'Clinic must be not empty';
                        }
                      },
                      controller: cliniccontroller,
                      decoration:InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Clinic' ,
                        prefixIcon: Icon(
                          Icons.bloodtype_outlined,
                        ),
                        border: OutlineInputBorder(),

                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    //medical
                    TextFormField(
                      validator:(value){
                        if(value==null)
                        {
                          return'Specification must be not empty';
                        }
                      },
                      controller: specificationcontroller,
                      decoration:InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Specification' ,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    //password
                    TextFormField(
                      validator:(value){
                        if(value==null);
                        {
                          return'Password must be not empty';
                        }
                      },
                      controller: passwordcontroller,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration:InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Password' ,
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    //confirm
                    TextFormField(
                      validator:(value){
                        if(value==null)
                        {
                          return'Password must be not empty';
                        }
                      },
                      controller: confirmpasscontroller,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration:InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Confirm Password' ,
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: ConditionalBuilder(
                        condition: state is RegisterLoadingState,
                        builder: (context)=>Center(
                          child: CircularProgressIndicator(
                            color: Colors.deepOrange,
                          ),
                        ),
                        fallback:(context)=> MaterialButton(
                          onPressed: (){
                            RegisterCubit.get(context).docRegister(
                                email: emailcontroller.text,
                                pass: passwordcontroller.text,
                                name: namecontroller.text,
                                start: startcontroller.text,
                                end: endcontroller.text,
                                specification: specificationcontroller.text,
                                clinic: cliniccontroller.text
                            );
                        },
                          child: Text(
                            'Sign Up' ,
                            style: TextStyle(
                              color: Colors.white ,
                            ),
                          ),
                          color: Colors.deepOrangeAccent,

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),


      ),
    );
  }
}