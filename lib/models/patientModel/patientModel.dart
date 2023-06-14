class PatientModel
{
  String? name;
  String? email;
  String? phone;
  String? BloodGroup;
  String image ='https://firebasestorage.googleapis.com/v0/b/patient-system-8ae7c.appspot.com/o/user.png?alt=media&token=5b4732a0-28b0-4b2e-8cbf-eb0721a43aa4';
  String? uId;
  String? history;
  String? birthdate;
  String? gender;
  int? age;
  bool isDoc=false;
  bool isActive=false;
  PatientModel(
      this.name,
      this.email,
      this.phone,
      this.BloodGroup,
      this.uId,
      this.history,
      this.age,
      this.birthdate,
      this.gender,
      this.isDoc,
      );
  PatientModel.fromJason(Map<String,dynamic>? jason)
  {
    name=jason!['name'];
    email=jason['email'];
    phone=jason['phone'];
    BloodGroup=jason['BloodGroup'];
    uId=jason['uId'];
    history=jason['history'];
    image=jason['image'];
    age=jason['age'];
    birthdate=jason['birthdate'];
    isDoc=jason['isDoc'];
    gender=jason['gender'];

  }
 Map<String,dynamic> toMap()
 {
   return{
     'name':name,
     'email':email,
     'BloodGroup':BloodGroup,
     'uId':uId,
     'history':history,
     'image':image,
      'phone':phone,
      'birthdate':birthdate,
      'age':age,
      'isDoc':isDoc,
      'gender':gender,
      'isActive':isActive,
   };
 }
}

class PatientAppoinementsModel
{
  String? clinic;
  String? endTime;
  String? specification;
  String? name;
  String? startTime;
  String? imageUrl;
  String? timeOfBooking;
  String? docId;
  bool? isActive ;

  PatientAppoinementsModel.fromJason(Map<String,dynamic>? jason)
  {
    clinic=jason!['clinic'];
    endTime=jason['endTime'];
    specification=jason['specification'];
    name=jason['name'];
    startTime=jason['startTime'];
    imageUrl=jason['image'];
    timeOfBooking=jason['bookingTime'];
    docId=jason['docId'];
    isActive=jason['isActive'];

  }

}