import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradutaionproject/models/doctorModel/doctorModel.dart';
import 'package:gradutaionproject/models/patientModel/patientModel.dart';
import 'package:gradutaionproject/modules/register/cubit/register_States.dart';
import 'package:gradutaionproject/shared/network/local/cache_helper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/constant/constant.dart';

class RegisterCubit extends Cubit<registerStates>
{
  RegisterCubit():super(initalState());

  static RegisterCubit get(context)=>BlocProvider.of(context);

bool isShown=false;

void changeVisablty ()
{
    isShown=!isShown;
    emit(ChangeVisabltyState());
  }

  void Register({
    required  String email,
    required String pass,
    required String name,
    required String phone,
    required String BloodGroup,
    required String history,
    required int age,
    required String birthdate,
    required String gender,
  })
  {
    FirebaseAuth
        .instance
        .createUserWithEmailAndPassword(
        email: email,
        password: pass
    ).then(
            (value)
        {
          createUser(
              email: email,
              BloodGroup: BloodGroup,
              name: name,
              history: history,
              phone: phone,
              uId:value.user!.uid,
              age: age,
            birthdate: birthdate,
            gender: gender

          );
          CacheHelper.putData('uId',value.user!.uid);
        }
    );
  }
  String dropButton(value)
  {

    emit(DropButtonState());
    return value;
  }
  void docRegister({
    required  String email,
    required String pass,
    required String name,
    required String start,
    required String end,
    required String specification,
    required String clinic,
  })
  {
    FirebaseAuth
        .instance
        .createUserWithEmailAndPassword(
        email: email,
        password: pass
    ).then(
            (value)
        {
          createDoctor(
              email: email,
              name: name,
              docId:value.user!.uid,
            start: start,
            end: end,
            specification: specification,
            clinic: clinic
          );
          CacheHelper.putData('docID',value.user!.uid);
        }
    );
  }
  void createUser({
    required  String name,
    required  String email,
    required String phone,
    required  String BloodGroup,
    required  String uId,
    required String history,
    required  int age,
    required String birthdate,
    required String gender,
    bool isDoc=false,
  })
  {
    emit(RegisterLoadingState());
    PatientModel model=PatientModel
      (
        name,
        email,
        phone,
        BloodGroup,
        uId,
        history,
        age,
      birthdate,
      gender,
      isDoc,
    );
    FirebaseFirestore.instance.collection('patient').doc(model.uId).set(model.toMap()).then(
            (value) {
          print('Create User Sucsses');
          emit(RegisterSucssesState());
        }
    )..catchError(
            (error)
        {
          emit(RegisterErrorState(error.toString()));
          print('Create user error');
        });
  }
  void createDoctor({
    required  String name,
    required  String email,
    required String start,
    required  String end,
    required  String docId,
    required String specification,
    required String clinic,
    bool isDoc=true,
  })
  {
    emit(DocRegisterLoadingState());
    DoctorModel model= DoctorModel(
        name,
        specification,
        start,
        end,
        clinic,
        docId,
    '00');
    FirebaseFirestore.instance.collection('doctors').doc(model.docId).set(model.toMap()).then(
            (value) {
          print('Create doctor Sucsses');
          emit(DocRegisterSucssesState());
        }
    )..catchError(
            (error)
        {
          emit(DocRegisterErrorState(error.toString()));
          print('Create doctor error');
        });
  }

  ImagePicker? picker=ImagePicker();
File? pickedImage;
void pickImages()
async{
  XFile? image = await picker!.pickImage(
      source: ImageSource.gallery
  );
pickedImage=File(image!.path);
emit(PickImageSucssesState());
}

void uploadImage(String collection,
  bool doc
)
{
  emit(UploadImageLoadingState());
  FirebaseStorage
      .instance
      .ref()
      .child('usersImage/${Uri.file(pickedImage!.path).pathSegments.last}')
      .putFile(pickedImage!).then
    (
      (p)
          {
            p.ref.getDownloadURL().then
              (
                (value)
                    {
                      FirebaseFirestore.instance
                          .collection(collection)
                      .doc(doc?CacheHelper.getData('docID'):CacheHelper.getData('uId'))
                      .update({
                        'image': value
                      }).then(
                              (value)
                          {
                            emit(UploadImageSucssesState());
                          }).catchError(
                              (error)
                          {
                            print('error in upload image');
                            emit(UploadImageErrorState(error.toString()));
                          }
                      );
                      print(doc);
                      print(value);

                    }
            );
          }
  );
}
}