
//all events

import 'package:flutter/cupertino.dart';

@immutable
abstract class UserEvent {}

//to take argument from event
class UserInitialEvent extends UserEvent {}

class UserViewedEvent extends UserEvent {
  final String UserId;

  UserViewedEvent(this.UserId);
}

class UserSearchUserEvent extends UserEvent {
  final String userName;

  UserSearchUserEvent(this.userName);
}

class UserShowErrorEvent extends UserEvent {
  final String msg;

  UserShowErrorEvent(this.msg);
}
