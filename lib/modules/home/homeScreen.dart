import 'package:flutter/material.dart';
import 'package:gradutaionproject/layouts/cubit/cubit.dart';
import 'package:gradutaionproject/modules/doctor/doctor_module.dart';
import 'package:gradutaionproject/shared/constant/constant.dart';

class Home_Screen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: ListView(
          children:  [
            CustomListTitle(context,
              imagePath: "assets/images/dentist.png",
              title: "Dentistry",
              onTap: () {
                navigatTo(
                  context,Doctor_Module(cubit.dentistry,'Dentistry')
                );

              },
            ),
            CustomListTitle(context,
              imagePath: "assets/images/dermatology.png",
              title: "Dermatology",
              onTap: ()  {
                navigatTo(
                    context,Doctor_Module(cubit.dermatology,'Dermatology')
                );
              },
            ),
            CustomListTitle(context,
              imagePath: "assets/images/ear.png",
              title: "Ear, nose and throat",
              onTap: () {},
            ),
            CustomListTitle(context,
              imagePath: "assets/images/gastroenterology.png",
              title: "Gastroenterology",
              onTap: () => {},
            ),
            CustomListTitle(context,
              imagePath: "assets/images/surgery.png",
              title: "Surgery",
              onTap: () => {},
            ),
            CustomListTitle(context,
              imagePath: "assets/images/hematology.png",
              title: "Hematology",
              onTap: () => {},
            ),
            CustomListTitle(context,
              imagePath: "assets/images/hepatology.png",
              title: "Hepatology",
              onTap: () => {},
            ),
            CustomListTitle(context,
              imagePath: "",
              title: "Internal Medicine",
              onTap: () => {},
            ),
            CustomListTitle(context,
              imagePath: "assets/images/neurology.png",
              title: "Neurology",
              onTap: () => {},
            ),
            CustomListTitle(context,
              imagePath: "assets/images/obstetrics.png",
              title: "Obstetrics and Gynecology",
              onTap: () => {},
            ),
            CustomListTitle(context,
              imagePath: "assets/images/ophthalmology.png",
              title: "Ophthalmology",
              onTap: () => {},
            ),
            CustomListTitle(context,
              imagePath: "assets/images/orthopedics.png",
              title: "Orthopedics",
              onTap: () => {

              },
            ),
            CustomListTitle(context,
              imagePath: "assets/images/pediatrics.png",
              title: "Pediatrics",
              onTap: () => {},
            ),
          ],
        ),
      ),
    );
  }

}

  Widget CustomListTitle(context,{
    required final String title,
   required  String imagePath,
    required VoidCallback? onTap,
}) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: SizedBox(
            width: 50,
            height: 50,
            child: imagePath==""? null : Image.asset(
              imagePath,
              fit: BoxFit.cover,
              color: Colors.white,
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

