import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradutaionproject/layouts/cubit/cubit.dart';
import 'package:gradutaionproject/layouts/homelayout/home_layout.dart';
import 'package:gradutaionproject/modules/login/cubit/login_States.dart';
import 'package:gradutaionproject/modules/login/cubit/login_cubit.dart';
import 'package:gradutaionproject/modules/register/register_screen.dart';
import 'package:gradutaionproject/shared/constant/constant.dart';
import 'package:gradutaionproject/shared/network/local/cache_helper.dart';
import 'package:hexcolor/hexcolor.dart';

class Login_Screen extends StatelessWidget
{
  Login_Screen({
 String email=''
})
  {
    emailcontroller.text=email;
  }
  var emailcontroller = TextEditingController() ;
  var passwordcontroller = TextEditingController() ;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool enable= true;
    return BlocConsumer<LoginCubit,loginStates>(
      listener: (context,state){
        if(state is LoginSucssesState)
        {
          print(state.uId);
          CacheHelper.putData('doc', AppCubit.get(context).isDoctor);
          CacheHelper.putData('uId', state.uId).then(
              (value)
                  {
                    navigatToAndFinish(context, Home_Layout());
                    AppCubit.get(context).getData();
                  }
          ).catchError(
              (error)
                  {
                    print(error.toString());
                  }
          );
        }
        if (state is LoginErrorState)
          {
          Fluttertoast.showToast(
              msg: state.error,
             toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red
          );
          }
        if(state is LoginLoadingState)
          {
            enable= false;
          }
        else
          {
            enable = true;
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
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome' ,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50.0 ,
                            fontFamily: 'welcome',
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('To your account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0 ,
                            fontWeight: FontWeight.bold ,
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        TextFormField(
                          validator: (value)
                          {
                            if(value!.isEmpty)
                              return'Email must be not empty';
                          },
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          decoration:InputDecoration(
                          labelStyle: TextStyle(
                            color: Colors.black54,
                          ),
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
                          height: 20.0,
                        ),
                        TextFormField(
                          validator: (value)
                          {
                            if(value!.isEmpty)
                              return'Password must be not empty';
                          },
                          controller: passwordcontroller,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: LoginCubit.get(context).isShown,
                          decoration:InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.black54,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Password' ,
                            prefixIcon: Icon(
                              Icons.lock,
                            ),
                            suffixIcon: IconButton(

                              onPressed: ()
                              {
                                if(enable)
                                LoginCubit.get(context).changeVisablty();
                              },
                              icon: Icon(
                                  LoginCubit.get(context).isShown? Icons.visibility:Icons.visibility_off
                              ),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        Container(
                          width: double.infinity,
                          height: 60,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: ConditionalBuilder(
                            condition: state is LoginLoadingState,
                            builder:(context)=>Center(
                                child: CircularProgressIndicator(
                                  color: Colors.deepOrange,
                                )
                            ) ,
                            fallback:(context)=> MaterialButton(
                              onPressed: (){
                                if(formKey.currentState!.validate())
                                  {
                                    LoginCubit.get(context).login(
                                        email: emailcontroller.text,
                                        password: passwordcontroller.text
                                    );
                                  }
                                if(emailcontroller.text.substring(0,4)=='doct')
                                  {
                                    AppCubit.get(context).isDoctor=true;
                                    print( AppCubit.get(context).isDoctor);
                                  }
                                else
                                  {
                                    AppCubit.get(context).isDoctor=false;
                                  }

                            },
                              child: Text(
                                'Login' ,
                                style: TextStyle(
                                  color: Colors.white ,
                                ),
                              ),
                              color: HexColor('#F19157'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        Row(
                          children: [
                            Text('Don\'t have an account ?',
                              style: TextStyle(
                                color: Colors.white.withOpacity(.8),
                              ),
                            ),
                            TextButton(
                              onPressed: (){
                                navigatTo(context, Register_Screen());
                              },
                              child: Text(
                                'Register now',
                                style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              color: Colors.white,
                              minWidth: 10,
                              onPressed: () {
                                AppCubit.get(context).isDoctor=false;
                               LoginCubit.get(context).signInWithGoogle(context);
                              },
                              child: Image(
                                image: AssetImage(
                                  'assets/images/google.png'
                                ),
                                height: 20,
                              )
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}