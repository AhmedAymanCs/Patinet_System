import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradutaionproject/models/patientModel/patientModel.dart';
import 'package:gradutaionproject/modules/DocAppoientment/cubit/states.dart';

import '../../../shared/constant/constant.dart';

class Doctor_Cubit extends Cubit<Doctor_States> {
  Doctor_Cubit() :super(InitailState());

  static Doctor_Cubit get(context) => BlocProvider.of(context);


  List<PatientModel> appointmentsDoctor = [];
  List<PatientModel> appointmentsAdmin = [];

  void getDocAppoientments(clinic) {
    appointmentsDoctor = [];
    FirebaseFirestore.instance.collection('appoientments')
        .doc(clinic).collection('appointments')
        .snapshots()
      .listen((event) {
        appointmentsDoctor=[];
      event.docs.forEach(
              (element) {
            if(element['isActive'])
              appointmentsDoctor.add(PatientModel.fromJason(element.data()));
          });

      emit(GetPatientDataSuccsesState());
    }
    ).onError(
            (error) {
          print('error in Get Appoienment data : ${error.toString()}');
          emit(GetPatientDataErrorState(error.toString()));
        });
  }


  Future getAdminAppoientments(clinic) async{
    appointmentsAdmin = [];
   return await FirebaseFirestore.instance.collection('appoientments')
        .doc(clinic).collection('appointments')
   .snapshots()
   .listen((event)
   {
     appointmentsAdmin=[];
     event.docs.forEach(
             (element) {
           if(!element['isActive'])
             appointmentsAdmin.add(PatientModel.fromJason(element.data()));
         });
     emit(GetPatientDataSuccsesState());
   });
  }


  void putPrescription(PatientModel Model) {
    emit(PutPrescriptionLoadingState());
    FirebaseFirestore.instance.collection('patient').doc(Model.uId).update({
      'history': '${Model.history}'
    }).then(
            (value) {
          clearBooking(Model);
          emit(PutPrescriptionSucssesState());
        }).catchError(
            (error) {
          print('error in PutPrescription:${error.toString()}');
          emit(PutPrescriptionErrorState(error.toString()));
        }
    );
  }

  void clearBooking(PatientModel Model,{String ? Clinic}) {
     emit(ClearAppoientmentLoadingState());
    FirebaseFirestore.instance
        .collection('patient')
        .doc(Model.uId)
        .collection('appointments').doc('${Clinic==null? globalClinic : Clinic} ${Model.name}')
        .delete()
        .then(
            (value) {
          FirebaseFirestore.instance
              .collection('appoientments')
              .doc(globalClinic)
              .collection('appointments').doc('${Model.name}').delete().then(
                  (value) {
                getAdminAppoientments(globalClinic).then((value) {
                  emit(ClearAppoientmentSucssesState());
                });

              }
          ).catchError(
                  (error) {
                emit(ClearAppoientmentErrorState(error.toString()));
              }
          );
        }
    );
  }


  void ActiveBooking(PatientModel Model,String Clinic) {
     emit(ActiveAppoientmentLoadingState());
    FirebaseFirestore.instance
        .collection('patient')
        .doc(Model.uId)
        .collection('appointments').doc('$Clinic ${Model.name}')
        .update({
      'isActive':true
    })
        .then(
            (value) {
          FirebaseFirestore.instance
              .collection('appoientments')
              .doc(Clinic)
              .collection('appointments').doc('${Model.name}').update({
            'isActive':true
          }).then(
                  (value) {
                 getAdminAppoientments(Clinic).then(
                         (value)
                     {
                       emit(ActiveAppoientmentSucssesState());
                     });

              }
          ).catchError(
                  (error) {
                emit(ActiveAppoientmentErrorState(error.toString()));
              }
          );
        }
    );
  }
}