import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradutaionproject/layouts/cubit/cubit.dart';
import 'package:gradutaionproject/layouts/cubit/states.dart';
import 'package:gradutaionproject/layouts/homelayout/home_layout.dart';
import 'package:gradutaionproject/modules/DocAppoientment/cubit/doc_cubit.dart';

import 'package:gradutaionproject/modules/login/cubit/login_cubit.dart';
import 'package:gradutaionproject/modules/login/login.dart';
import 'package:gradutaionproject/modules/register/cubit/register_cubit.dart';
import 'package:gradutaionproject/shared/bloc_observer.dart';
import 'package:gradutaionproject/shared/constant/constant.dart';
import 'package:gradutaionproject/shared/network/local/cache_helper.dart';
import 'package:hexcolor/hexcolor.dart';

import 'modules/pickImageScreen/pickImage_Screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Widget widget;
  String uId = CacheHelper.getData('uId')??'';
  bool isDark =CacheHelper.getData('darkMode')??false ;
  if(uId=='')
    {
    widget=Login_Screen();
    }
  else
    {
      widget=Home_Layout();

    }
  runApp(MyApp(widget,));
}

class MyApp extends StatelessWidget {
Widget widget;
MyApp(this.widget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context)=>AppCubit()..getData()..getDoctorData()..getAppoientments(),
        ),
        BlocProvider(
            create:(context)=>LoginCubit(),
        ),
        BlocProvider(
            create:(context)=>RegisterCubit(),
        ),
        BlocProvider(
            create:(context)=>Doctor_Cubit(),
        ),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder:(context,state)=> MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            iconTheme: IconThemeData(
              color: Colors.black45,
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.white.withOpacity(0.7),
              selectedItemColor: deepColor,
            ),
            scaffoldBackgroundColor: HexColor(backgroundColor),
              appBarTheme: AppBarTheme(
                backgroundColor: HexColor(backgroundColor),
                elevation: 0
              ),
              textTheme: TextTheme(
                  labelLarge: TextStyle(
                      color: Colors.white
                  ),
                  labelMedium: TextStyle(
                      color: Colors.white.withAlpha(250),
                      fontWeight: FontWeight.w300
                  ),
                  bodyLarge : TextStyle(
                      color: Colors.white
                  ),
                titleLarge: TextStyle(
                    color: Colors.white
                ),
              )
          ),
          themeMode:AppCubit.get(context).isDark? ThemeMode.dark: ThemeMode.light,
          darkTheme: ThemeData(
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.white.withOpacity(0.7),
                selectedItemColor: deepColor,
              ),
              appBarTheme: AppBarTheme(
                  backgroundColor: Colors.black,
                  elevation: 0
              ),
              textTheme: TextTheme(
                labelLarge: TextStyle(
                    color: Colors.white
                ),
                labelMedium: TextStyle(
                    color: Colors.white.withAlpha(250),
                    fontWeight: FontWeight.w300
                ),
                bodyLarge : TextStyle(
                    color: Colors.white
                ),
                titleLarge: TextStyle(
                    color: Colors.white
                ),
              ),
            scaffoldBackgroundColor: Colors.black
          ),
          home: widget,
        ),
      ),
    );
  }
}

