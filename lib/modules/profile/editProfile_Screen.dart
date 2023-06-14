import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradutaionproject/layouts/cubit/cubit.dart';
import 'package:gradutaionproject/layouts/homelayout/home_layout.dart';
import 'package:gradutaionproject/modules/login/login.dart';
import 'package:gradutaionproject/modules/pickImageScreen/pickImage_Screen.dart';
import 'package:gradutaionproject/modules/register/cubit/register_States.dart';
import 'package:gradutaionproject/modules/register/cubit/register_cubit.dart';
import 'package:gradutaionproject/shared/constant/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../layouts/cubit/states.dart';

class editProfile_Screen extends StatelessWidget
{
  var namecontroller = TextEditingController() ;

  var emailcontroller = TextEditingController() ;

  var phonecontroller = TextEditingController() ;

  var datecontroller = TextEditingController() ;

  var bloodcontroller = TextEditingController() ;

  var confirmpasscontroller = TextEditingController() ;

  var medicalhistorycontroller = TextEditingController() ;

  var passwordcontroller = TextEditingController() ;

  String? Gender;

  String? Blood ;
  var bloodItems = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];
  var genderItems = [
    'Male',
    'Female',
  ];

  int? age=0;

  editProfile_Screen(
  {
    required String? name,
    required String? email,
    required String? phone,
    required String? date,
    required String? blood,
    required String? gender,
}
      )
  {
    namecontroller.text=name!;
    emailcontroller.text=email!;
    phonecontroller.text=phone!;
    datecontroller.text=date!;
    Blood=blood!;
    Gender=gender;

  }
  @override
  Widget build(BuildContext context) {
    AppCubit cubit =BlocProvider.of(context);
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){
        if(state is UpdateuserDataSucssesState)
        {
          navigatToAndFinish(
              context,
            Home_Layout()
          );
        }
      },
      builder:(context,state)=> Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10
              ),
              child: ConditionalBuilder(
                condition: state is UpdateuserDataLoadingState,
                builder: (context)=>Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
                fallback: (context) =>TextButton(
                    onPressed: ()
                    {
                      if(cubit.isActivated)
                        {
                          cubit.updateUserData(
                              name: namecontroller.text,
                              phone: phonecontroller.text,
                              blood: Blood,
                              date: datecontroller.text,
                              age: age,
                              gender:Gender
                          );
                        }
                      else
                        {
                          cubit.getReadyUpdateData();
                        }

                    },
                    child: Text(
                        cubit.isActivated ? 'Upload':'Update',
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(
                  height: 10.0,
                ),
                //name
                TextFormField(
                  enabled: cubit.isActivated,
                  validator:(value){
                    if(value==null)
                    {
                      return'Name must be not empty';
                    }
                  },
                  controller: namecontroller,
                  decoration:InputDecoration(
                    filled: true,
                    fillColor: cubit.isActivated ?Colors.white : Colors.grey,
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
                  enabled: false ,
                  validator:(value){
                    if(value==null)
                    {
                      return'Email must be not empty';
                    }
                  },
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration:InputDecoration(
                    filled: true,
                    fillColor: Colors.grey,
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
                  enabled: cubit.isActivated,
                  validator:(value){
                    if(value==null)
                    {
                      return'Phone must be not empty';
                    }
                  },
                  controller: phonecontroller,
                  decoration:InputDecoration(
                    filled: true,
                     fillColor: cubit.isActivated ?Colors.white : Colors.grey,
                    labelText: 'Phone' ,
                    prefixIcon: Icon(
                        Icons.phone
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                //date
                TextFormField(
                  enabled: cubit.isActivated,
                  validator:(value){
                    if(value==null)
                    {
                      return'Date must be not empty';
                    }
                  },
                  controller: datecontroller,
                  onTap: ()
                  {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2200),
                    ).then(
                            (value)
                        {
                          datecontroller.text=DateFormat.yMMMd().format(value!);
                          age =  DateTime.now().year-value.year;
                          print(age);
                        }
                    );
                  },
                  decoration:InputDecoration(
                    filled: true,
                     fillColor: cubit.isActivated ?Colors.white : Colors.grey,
                    labelText: 'Birthdate' ,
                    prefixIcon: Icon(
                      Icons.date_range_outlined,
                    ),
                    border: OutlineInputBorder(),

                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                //blood
                // TextFormField(
                //   enabled: cubit.isActivated,
                //   validator:(value){
                //     if(value==null)
                //     {
                //       return'Blood Group must be not empty';
                //     }
                //   },
                //   controller: bloodcontroller,
                //   decoration:InputDecoration(
                //     filled: true,
                //      fillColor: cubit.isActivated ?Colors.white : Colors.grey,
                //     labelText: 'Blood Group' ,
                //     prefixIcon: Icon(
                //       Icons.bloodtype_outlined,
                //     ),
                //     border: OutlineInputBorder(),
                //
                //   ),
                // ),
                Row(
                  children: [
                    Text(
                        'Blood Group',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.all(10),
                      child: DropdownButton(
                          value:Blood,
                          items:bloodItems.map(
                                  (item)
                              {
                                return DropdownMenuItem<String>(
                                  child:Text(item),
                                  value: item,
                                );
                              }
                          ).toList(),

                          onChanged: (String? value) {

                           Blood= cubit.dropButton(value);
                            print(Blood);
                          }
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                        'Gender',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(
                      width: 36,
                    ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.all(10),
                      child: DropdownButton(
                          value:Gender,
                          items:genderItems.map(
                                  (item)
                              {
                                return DropdownMenuItem<String>(
                                  child:Text(item),
                                  value: item,
                                );
                              }
                          ).toList(),
                          onChanged: (String? value) {

                           Gender= cubit.dropButton(value);

                          }
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: deepColor,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: TextButton(
                      onPressed: ()
                      {
                        registered = true;
                        navigatTo(
                            context,
                            PickImageScreen()
                        );

                      },
                      child: Text(
                        'Update Image',
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                  ),
                )
                //medical

              ],
            ),
          ),
        ),


      ),
    );
  }
}