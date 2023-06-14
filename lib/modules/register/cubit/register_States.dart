abstract class registerStates{}

class initalState extends registerStates {}

class PickImageSucssesState extends registerStates {}

class RegisterLoadingState extends registerStates {}

class ChangeVisabltyState extends registerStates {}


class DropButtonState extends registerStates {}

class RegisterSucssesState extends registerStates {
  // final uId;
  // RegisterSucssesState(this.uId);

}

class RegisterErrorState extends registerStates {
  final error;
  RegisterErrorState(this.error);
}

class UploadImageLoadingState extends registerStates{}
class UploadImageSucssesState extends registerStates{}
class UploadImageErrorState extends registerStates{
  final error;

  UploadImageErrorState(this.error);

}


class DocRegisterLoadingState extends registerStates {}

class DocRegisterSucssesState extends registerStates {
  // final uId;
  // DocRegisterSucssesState(this.uId);

}

class DocRegisterErrorState extends registerStates {
  final error;
  DocRegisterErrorState(this.error);
}
