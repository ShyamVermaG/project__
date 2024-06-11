import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_bar/features/Users/Bloc/Users/user_events.dart';
import 'package:search_bar/features/Users/Bloc/Users/user_states.dart';

import '../../../../API/FetchUsers.dart';
import '../../../../Models/User.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  //for default passing eanbility
  UserBloc() : super(UserInitialState()) {
    on<UserInitialEvent>(ItemInitialMethod);
    on<UserViewedEvent>(UserViewedMethod);
    on<UserSearchUserEvent>(UserSearchUserMethod);
    on<UserShowErrorEvent>(userShowErrorEvent);
  }



  User user = User("id", "name", "height", "img","height");
  bool dataFound = true;
  String userId = "sdf";

  //all loaded data stored here
  List<User> loadedUsers = [];
  //this is for showing the data or apply a search on it
  List<User> tampUsers = [];

  Future<FutureOr<void>> ItemInitialMethod(
      UserEvent event, Emitter<UserState> emit) async {



    emit(UserLoadingState());
    
    //fetch data from data base
    try{
      loadedUsers=await fetchUsers();
      tampUsers=loadedUsers;

    }catch(e){
      emit(UserShowErrorState("Error Occured Fetching data"+e.toString()));

      print("Error"+e.toString());
      emit(UserNotFoundState());
    }

    emit(UserLoadedSuccessState(tampUsers));


  }

  FutureOr<void> UserViewedMethod(
      UserViewedEvent event, Emitter<UserState> emit) {
    print("ItemClicked Event");
  }



  //apply search
  Future<FutureOr<void>> UserSearchUserMethod(
      UserSearchUserEvent event, Emitter<UserState> emit) async {
    // print("AddUser Event" + event.userName);

    emit(UserLoadingState());

    tampUsers=[];
    tampUsers=loadedUsers.where((user) => user.name.toLowerCase().contains(event.userName)).toList();

    //calculate searching


    if(tampUsers.isNotEmpty)
      emit(UserLoadedSuccessState(tampUsers));
    else{
      emit(UserShowErrorState("User Not Found"));
      emit(UserNotFoundState());

    }




  }

  @override
  void onChange(Change<UserState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change.currentState);
    print("to");
    print(change.nextState);
  }


  FutureOr<void> userShowErrorEvent(UserShowErrorEvent event, Emitter<UserState> emit) {
    emit(UserShowErrorState(event.msg));

  }
}
