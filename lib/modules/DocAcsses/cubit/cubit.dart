import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradutaionproject/modules/DocAcsses/cubit/states.dart';

import '../../../models/ClinicPasswrodModel/ClinicPasswrodModel.dart';

class DocAcssesCubit extends Cubit<DocAcssesStates>
{
  DocAcssesCubit():super(DocAcssesInitState());

 static DocAcssesCubit get(context) => BlocProvider.of(context);

  ClinicPasswrodModel? data;

  void getAcssesInfo()
  {
    FirebaseFirestore.instance
        .collection('CPassword')
        .doc('1')
        .get()
        .then((value)
          {
            data =ClinicPasswrodModel.fromJason(value.data()!);
            print(data!.Admin);
          }
          ).catchError(
        (error)
            {
              print('Error in get CPassword');
            }
    );
  }

}