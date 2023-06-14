import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradutaionproject/layouts/cubit/cubit.dart';
import 'package:gradutaionproject/layouts/cubit/states.dart';

import 'package:gradutaionproject/shared/constant/constant.dart';
import 'package:gradutaionproject/shared/network/local/cache_helper.dart';

class Setting_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder:(context,state) =>Scaffold(
        appBar: AppBar(
          title: Text(
              'Settings'
          ),
        ),
        body: Column(
          children:
          [
            Container(
              color: Colors.white70.withOpacity(.1),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Dark Mode',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 25,
                    ),
                  ),
                  Spacer(),
                  Switch(
                      activeColor: deepColor,
                      value: AppCubit.get(context).isDark,
                      onChanged: (value)
                      {
                        AppCubit.get(context).switchDarkMode(value);

                      }
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
