import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradutaionproject/layouts/cubit/cubit.dart';
import 'package:gradutaionproject/layouts/cubit/states.dart';
import 'package:gradutaionproject/modules/DocAcsses/DocAccess_Screen.dart';
import 'package:gradutaionproject/modules/DocAppoientment/DocAppoientment_Screen.dart';
import 'package:gradutaionproject/modules/login/login.dart';
import 'package:gradutaionproject/shared/constant/constant.dart';
import 'package:gradutaionproject/shared/network/local/cache_helper.dart';
import 'package:hexcolor/hexcolor.dart';

class Home_Layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder:(context,state)=> ConditionalBuilder(
        condition: CacheHelper.getData('doc')??false,
        builder:(context)=> Doc_Acsses(),
        fallback:(context)=> Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              if(cubit.currentIndex==1)
                IconButton(
                  onPressed: (){
                    AppCubit.get(context).getAppoientments();
                    AppCubit.get(context).getData();
                  },
                  icon: Icon(
                      Icons.refresh
                  ),
                )

            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon:Icon(
                    Icons.home_filled,
                  ),
                  label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon:Icon(
                    Icons.watch_later_outlined,
                  ),
                  label: 'Appoientments'
              ),
              BottomNavigationBarItem(
                  icon:Icon(
                    Icons.menu,
                  ),
                  label: 'Menu'
              ),
            ],
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottomIndex(index);
            },
          ),
        ),
      ),
    );
  }
}
