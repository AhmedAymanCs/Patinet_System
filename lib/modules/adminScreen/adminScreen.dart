import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradutaionproject/modules/DocAppoientment/AdminAppoientment_Screen.dart';
import 'package:gradutaionproject/modules/register/Docregister_screen.dart';
import 'package:gradutaionproject/shared/constant/constant.dart';

class Admin_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var scafKey=GlobalKey<ScaffoldState>();
    return Scaffold(
      key:scafKey ,
      drawer: Container(
        color: Colors.white.withOpacity(0.7),
        width: MediaQuery.of(context).size.width-(MediaQuery.of(context).size.width/2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: deepColor,
                borderRadius: BorderRadius.circular(10)
              ),
              child: TextButton(
                  onPressed: (){
                    navigatTo(context, Doc_Register_Screen());
                  },
                  child: Text(
                      'Register',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  )
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back
          ),
        ),
        actions: [
          IconButton(
              onPressed: ()
              {
                scafKey.currentState!.openDrawer();
              },
              icon: Icon(
                Icons.menu
              )
          )
        ],
      ),
      body:ListView(
        children:  [
          CustomListTitle(context,
            imagePath: "assets/images/dentist.png",
            title: "Dentistry",
            onTap: () {

            navigatTo(
                context,
                Admin_Appoientment_Screen(clinic:'Dentistry',)
            );
            },
          ),
          CustomListTitle(context,
            imagePath: "assets/images/dermatology.png",
            title: "Dermatology",
            onTap: ()  {
              navigatTo(
                  context,
                  Admin_Appoientment_Screen(clinic:'Dermatology',)
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
    );
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

}
