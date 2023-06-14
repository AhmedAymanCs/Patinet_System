abstract class AppStates{}

class initalState extends AppStates{}

class ChangeBottomNavigationIndexState extends AppStates{}

class GetDataLoadingState extends AppStates{}
class GetDataSucssesState extends AppStates{}
class GetDataErrorState extends AppStates{
  final error;
  GetDataErrorState(this.error);
}


class BookingLoadingState extends AppStates{}
class BookingSucssesState extends AppStates{}
class BookingErrorState extends AppStates{
  final error;
  BookingErrorState(this.error);
}


class GetAppointmentLoadingState extends AppStates{}
class GetAppointmentSuccssesState extends AppStates{}
class GetAppointmentErrorState extends AppStates{
  final error;
  GetAppointmentErrorState(this.error);
}


class delBookingLoadingState extends AppStates{}
class delBookingSucssesState extends AppStates{}
class delBookingErrorState extends AppStates{
  final error;
  delBookingErrorState(this.error);
}


class GetDoctorDataLoadingState extends AppStates{}
class GetDoctorDataSucssesState extends AppStates{}
class GetDoctorDataErrorState extends AppStates{
  final error;
  GetDoctorDataErrorState(this.error);
}



class GetReadyUpdateDateState extends AppStates{}
class SettingChangeDarkModeState extends AppStates{}


class DropButtonState extends AppStates{}

class UpdateuserDataLoadingState extends AppStates{}
class UpdateuserDataSucssesState extends AppStates{}
class UpdateuserDataErrorState extends AppStates{
  final error;
  UpdateuserDataErrorState(this.error);
}



