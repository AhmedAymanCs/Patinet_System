abstract class Doctor_States {}

class InitailState extends Doctor_States {}

class GetPatientDataLoadingState extends Doctor_States {}
class GetPatientDataSuccsesState extends Doctor_States {}
class GetPatientDataErrorState  extends Doctor_States {
  final error;
  GetPatientDataErrorState(this.error);
}


class PutPrescriptionLoadingState extends Doctor_States{}
class PutPrescriptionSucssesState extends Doctor_States{}
class PutPrescriptionErrorState extends Doctor_States{
  final error;
  PutPrescriptionErrorState(this.error);
}
class ActiveAppoientmentLoadingState extends Doctor_States{}
class ActiveAppoientmentSucssesState extends Doctor_States{}
class ActiveAppoientmentErrorState extends Doctor_States{
  final error;

  ActiveAppoientmentErrorState(this.error);
}

class ClearAppoientmentLoadingState extends Doctor_States{}
class ClearAppoientmentSucssesState extends Doctor_States{}
class ClearAppoientmentErrorState extends Doctor_States{
  final error;

  ClearAppoientmentErrorState(this.error);
}