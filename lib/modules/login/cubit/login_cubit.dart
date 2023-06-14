import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gradutaionproject/layouts/cubit/cubit.dart';
import 'package:gradutaionproject/modules/login/cubit/login_States.dart';
import 'package:gradutaionproject/modules/register/cubit/register_cubit.dart';

class LoginCubit extends Cubit<loginStates>
{
  LoginCubit():super(initalState());

  static LoginCubit get(context)=>BlocProvider.of(context);

bool isShown=true;

void changeVisablty ()
  {
    isShown=!isShown;
    emit(ChangeVisabltyState());
  }

  void login({
    required String email,
    required String password,
  })
  {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email:email ,
      password: password,
    )
        .then(
            (value)
        {
          print('login sucsses');
          emit(LoginSucssesState(value.user!.uid));

        }
    ).catchError(
        (error)
            {
              String fError= error.toString();
             if(error.toString()=='[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.')
               {
                 fError='We have blocked all requests from this device due to unusual activity. Try again later';
               }
             else if (error.toString()=='[firebase_auth/wrong-password] The password is invalid or the user does not have a password.')
             {
               fError='The password is invalid';
             }
             else if (error.toString()=='[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.')
             {
               fError='No user for this email';
             }
             print(error.toString());

              emit(LoginErrorState(fError));
            }
    );
  }
  void signInWithGoogle(context) async {
    emit(LoginLoadingState());
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    FirebaseAuth.instance.signInWithCredential(credential)
        .then(
            (value)
        {
          print(value.user);
          RegisterCubit.get(context)
              .createUser
            (
              name: value.user!.displayName ?? '',
              email: value.user!.email ?? '',
              phone: value.user!.phoneNumber ?? '',
              BloodGroup: 'Empty',
              uId: value.user!.uid,
              history: 'empty',
              age: 0,
            birthdate: 'Anonymous',
            gender: 'Anonymous',
            isDoc: false,
          );
          emit(LoginSucssesState(value.user!.uid));
        });
  }

}