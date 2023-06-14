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

class Register_Screen extends StatelessWidget
{
  var namecontroller = TextEditingController() ;
  var emailcontroller = TextEditingController() ;
  var phonecontroller = TextEditingController() ;
  var datecontroller = TextEditingController() ;
  var confirmpasscontroller = TextEditingController() ;
  var medicalhistorycontroller = TextEditingController() ;
  var passwordcontroller = TextEditingController() ;
  var gender ='Male';
  int age=0;
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
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit,registerStates>(
      listener: (context,state){
        if(state is RegisterSucssesState)
          {
            navigatToAndFinish(
                context,
                PickImageScreen(email: emailcontroller.text,)
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
                          return'Phone must be not empty';
                        }
                      },
                      controller: phonecontroller,
                      decoration:InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
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
                      validator:(value){
                        if(value==null);
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
                            }
                        );
                      },
                      decoration:InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
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

                                Blood= RegisterCubit.get(context).dropButton(value);
                                print(Blood);
                              }
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    //medical
                    TextFormField(
                      validator:(value){
                        if(value==null);
                        {
                          return'Medical History must be not empty';
                        }
                      },
                      controller: medicalhistorycontroller,
                      decoration:InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Medical History' ,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
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
                              value:gender,
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

                                gender= RegisterCubit.get(context).dropButton(value);

                              }
                          ),
                        ),
                      ],
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
                        if(value==null);
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
                            RegisterCubit.get(context).Register
                              (
                                email: emailcontroller.text,
                                pass: passwordcontroller.text,
                                name: namecontroller.text,
                                phone: phonecontroller.text,
                                BloodGroup: Blood!,
                                history: medicalhistorycontroller.text,
                                age: age,
                                gender: gender,
                                birthdate: datecontroller.text
                            );

                          print(emailcontroller.text);
                          print(passwordcontroller.text);
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