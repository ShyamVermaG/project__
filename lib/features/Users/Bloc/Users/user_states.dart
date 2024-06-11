
//all the states
import 'package:flutter/cupertino.dart';

import '../../../../Models/User.dart';

@immutable
abstract class UserState {}

class UserShowErrorState extends UserState {
  final String msg;

  UserShowErrorState(this.msg);
}



class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

//for initial show,error showed and sucess data show
class UserLoadedSuccessState extends UserState {

  final List<User> tampUsers;

  // final Partner partner;

  UserLoadedSuccessState(this.tampUsers);
}

class UserNotFoundState extends UserState {}
