abstract class loginStates{}

class initalState extends loginStates {}

class LoginLoadingState extends loginStates {}
class ChangeVisabltyState extends loginStates {}

class LoginSucssesState extends loginStates {
  final uId;
  LoginSucssesState(this.uId,);

}

class LoginErrorState extends loginStates {
  final error;
  LoginErrorState(this.error);
}