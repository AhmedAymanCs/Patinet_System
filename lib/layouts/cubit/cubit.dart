import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradutaionproject/layouts/cubit/states.dart';
import 'package:gradutaionproject/models/doctorModel/doctorModel.dart';
import 'package:gradutaionproject/models/patientModel/patientModel.dart';
import 'package:gradutaionproject/modules/DocAppoientment/cubit/doc_cubit.dart';
import 'package:gradutaionproject/modules/appoientments/appoientments.dart';
import 'package:gradutaionproject/modules/home/homeScreen.dart';
import 'package:gradutaionproject/modules/menu/menu_screen.dart';
import 'package:gradutaionproject/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit():super(initalState());

  static AppCubit get(context)=>BlocProvider.of(context);

  bool isDark = CacheHelper.getData('darkMode')??false;
  void switchDarkMode(bool dark)
  {
    isDark=dark;
    CacheHelper.putData('darkMode', dark);
    emit(SettingChangeDarkModeState());
  }

int currentIndex=0;
bool isDoctor= false;
List<Widget> screens=[
  Home_Screen(),
  Appoientments_Screen(),
  Menu_Screen()
];
List<String> titles =[
  'Home',
  'Appoientments',
  'Menu',
];
void changeBottomIndex(int index)
{
  currentIndex=index;
  emit(ChangeBottomNavigationIndexState());
}

  PatientModel? model;
  List<PatientAppoinementsModel> appointments=[];

  void getData()
  {
    emit(GetDataLoadingState());
    if(CacheHelper.getData('uId')!=null||CacheHelper.getData('uId')=='')
      {
        FirebaseFirestore.instance.collection('patient')
            .doc(CacheHelper.getData('uId'))
            .get()
            .then(
                (value)
            {
              model=PatientModel.fromJason(value.data());
              emit(GetDataSucssesState());

            }
        ).catchError(
                (error)
        {
          print('error in Get data');
          emit(GetDataErrorState(error.toString()));
        });


      }
    else
      {
        print('Login Frist');
      }

  }

  void getAppoientments()
  {
    emit(GetAppointmentLoadingState());
    appointments=[];
    FirebaseFirestore.instance.collection('patient')
        .doc(CacheHelper.getData('uId')).collection('appointments')
    .snapshots()
    .listen((event)
    {
      appointments=[];
      event.docs.forEach(
              (element)
          {
            appointments.add(PatientAppoinementsModel.fromJason(element.data()));
          });

      emit(GetAppointmentSuccssesState());
    }
    ).onError(
            (error)
        {
          emit(GetAppointmentErrorState(error.toString()));
        });
  }

  void Booking(context,DoctorModel docModel)
  {
    docModel.bookingTime=TimeOfDay.now().format(context);
    emit(BookingLoadingState());
    FirebaseFirestore.instance
        .collection('patient')
        .doc(CacheHelper.getData('uId'))
        .collection('appointments').doc('${docModel.clinic} ${model!.name}').set(docModel.toMap()).then(
            (value)
        {
        }
    );
    FirebaseFirestore.instance
        .collection('appoientments')
        .doc('${docModel.clinic}')
        .collection('appointments').doc('${model!.name}').set(model!.toMap()).then(
            (value)
        {
          getAppoientments();
          emit(BookingSucssesState());
        }
    ).catchError(
        (error)
            {
              emit(BookingErrorState(error.toString()));
            }
    );
  }
  void CancelBooking(PatientAppoinementsModel docModel)
  {
    emit(delBookingLoadingState());
    FirebaseFirestore.instance
        .collection('patient')
        .doc(CacheHelper.getData('uId'))
        .collection('appointments').doc('${docModel.clinic} ${model!.name}').delete().then(
            (value)
        {
          FirebaseFirestore.instance
              .collection('appoientments')
              .doc(docModel.clinic)
              .collection('appointments').doc('${model!.name}').delete().then(
                  (value)
              {
                getAppoientments();
                emit(delBookingSucssesState());
              }
          ).catchError(
                  (error)
              {
                emit(delBookingErrorState(error.toString()));
              }
          );
        }
    );

  }
  List<DoctorModel> dentistry=[];
  List<DoctorModel> dermatology=[];

  List<DoctorModel> doctors=[];
  void getDoctorData()
  {
    emit(GetDoctorDataLoadingState());
    FirebaseFirestore.instance
        .collection('doctors')
        .get()
        .then(
        (value)
            {
              value.docs.forEach(
                  (element)
                      {
                      doctors.add(DoctorModel.fromJason(element.data()));
                      print('element');
                      }

              );
              doctors.forEach(
                      (element)
                  {
                    if (element.clinic=='Dentistry')
                      {
                        dentistry.add(element);
                      }
                    if (element.clinic=='Dermatology')
                    {
                      dermatology.add(element);
                    }
                  });

              emit(GetDoctorDataSucssesState());
            }
    ).catchError(
        (error)
        {
          emit(GetDoctorDataErrorState(error.toString()));
          print(error.toString());
        }
    )
    ;
  }
  bool isActivated= false;
  void getReadyUpdateData()
  {
    isActivated=true;
    emit(GetReadyUpdateDateState());
  }

  void updateUserData(
  {
  required String? name,
  required String? phone,
  required String? blood,
  required String? date,
  required String? gender,
  required int? age,
}
      )
  {
    emit(UpdateuserDataLoadingState());
    FirebaseFirestore
        .instance
        .collection('patient')
        .doc(CacheHelper.getData('uId'))
        .update(
        {
      'name':name,
      'birthdate':date,
      'phone':phone,
      'BloodGroup':blood,
      'age':age,
      'gender':gender,
        }
    ).then(
       (value)
       {
         print('Update Sucsses');
         emit(UpdateuserDataSucssesState());
         getData();
         isActivated= false;
       }
    ).catchError(
        (error)
            {
              print('Update error : ${error.toString()}');
              emit(UpdateuserDataErrorState(error.toString()));
            }
    );
  }
 String? globalClinic;


  String dropButton(value)
  {

    emit(DropButtonState());
    return value;
  }





}