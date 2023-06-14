class DoctorModel
{
  String? name;
  String? specification;
  String? startTime;
  String? endTime;
  String? clinic;
  String? docId;
  String? image='https://firebasestorage.googleapis.com/v0/b/patient-system-8ae7c.appspot.com/o/doctor.jpg?alt=media&token=1068624a-7e73-42ae-bd84-b5dcb16bb012';
  String? bookingTime;
  bool isActive =false;
  DoctorModel(
      this.name,
      this.specification,
      this.startTime,
      this.endTime,
      this.clinic,
      this.docId,
      this.bookingTime,
  {
    this.image
  }
      );
  DoctorModel.fromJason(Map<String,dynamic> jason)
  {
    name=jason['name'];
    specification=jason['specification'];
    startTime=jason['startTime'];
    endTime=jason['endTime'];
    clinic=jason['clinic'];
    docId=jason['docID'];
    image=jason['image'];
    bookingTime=jason['bookingTime'];
  }
  Map<String,dynamic> toMap( )
  {
    return{
      'name':name,
      'specification':specification,
      'startTime':startTime,
      'endTime':endTime,
      'clinic':clinic,
      'docID':docId,
      'image':image,
      'bookingTime':bookingTime,
      'isActive':isActive,
    };
  }
}