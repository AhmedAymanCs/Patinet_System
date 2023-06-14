import 'package:flutter/material.dart';
import 'package:gradutaionproject/modules/Setting/settingScreen.dart';
import 'package:gradutaionproject/modules/profile/profile_Screen.dart';
import 'package:gradutaionproject/shared/network/local/cache_helper.dart';

import '../../shared/constant/constant.dart';
import '../login/login.dart';

class Menu_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomListIcon(context,
          icon: Icons.person,
          onTap: (){
          navigatTo(context, ProfileScreen());
          },
          title:'Profile',
        ),
        CustomListIcon(context,
          icon: Icons.settings,
          onTap: (){
          navigatTo(context, Setting_Screen());
          },
          title:'Settings',
        ),
        CustomListIcon(context,
          icon: Icons.output_sharp,
          onTap: (){
            CacheHelper.removedata('uId').then(
                    (value)
                {
                  navigatToAndFinish(context, Login_Screen());

                }
            );
          },
          title:'Sign out',
        ),
      ],
    );
  }
}
Widget CustomListIcon(context,{
  required final String title,
  required  IconData icon,
  required VoidCallback? onTap,
}) {
  return Column(
    children: [
      ListTile(
        onTap: onTap,
        leading: SizedBox(
          width: 40,
          height: 40,
          child:Icon(
            icon,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      Divider(
        color: Colors.white,
      ),
    ],
  );
}