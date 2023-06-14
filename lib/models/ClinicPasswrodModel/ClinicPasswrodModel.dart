class ClinicPasswrodModel
{
  String? Dentistry;
  String? Dermatology;
  String? Admin;
  String? ear;
  String? Surgery;

  ClinicPasswrodModel.fromJason(Map<String,dynamic> jason)
  {
    Dentistry=jason['Dentistry'];
    Dermatology=jason['Dermatology'];
    Admin=jason['Admin'];
    ear=jason['ear'];
    Surgery=jason['Surgery'];
  }

}