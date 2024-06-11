import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Models/User.dart';
// import '../../UserProfile/UserProfile.dart';
import '../../Counter/CounterS.dart';
import '../Bloc/Users/user_block.dart';
import '../Bloc/Users/user_events.dart';
import '../Bloc/Users/user_states.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList>  with AutomaticKeepAliveClientMixin{
  UserBloc userBloc = UserBloc();
  TextEditingController _searchController = TextEditingController();


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive =>true;

  @override
  void initState() {
    // TODO: implement initState

    userBloc.add(UserInitialEvent());
    super.initState();
  }

  //for hide and show the search bar
  bool isBarEnable=false;
  enableDisableSearchbar(){

    isBarEnable=!isBarEnable;

    setState(() {

    });
  }

  //for implementing search
  applySearch(String value) {
    userBloc.add(UserSearchUserEvent(value.toLowerCase()));
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            constraints: BoxConstraints(
              maxWidth: 500
            ),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                 appBarCustom(),

                //for custom search Bar
                SearchBarCustom2(),


                Expanded(
                  flex: 1,
                  child: BlocConsumer<UserBloc, UserState>(
                    bloc: userBloc,

                    listenWhen: (context,state){
                      if(state.runtimeType==UserShowErrorState)
                        return true;
                      else
                        return false;
                    },
                    buildWhen: (context,state){
                      if(state.runtimeType!=UserShowErrorState)
                        return true;
                      else
                        return false;
                    },
                    listener: (context,state){
                      final sucessState = state as UserShowErrorState;

                      final snackBar = SnackBar(
                        content: Text(sucessState.msg),
                        duration: Duration(seconds: 2),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);


                    },
                    builder: (context, state) {
                      switch (state.runtimeType) {


                        //if sucess show data
                        case UserLoadedSuccessState:
                          final sucessState = state as UserLoadedSuccessState;

                          return ListView.builder(
                            itemCount: sucessState.tampUsers.length,
                            itemBuilder: (context, index) {
                              return partnerDataWidget(
                                  sucessState.tampUsers[index]);
                            },
                          );


                          //for loading show
                        case UserLoadingState:
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    margin: EdgeInsets.all(10),
                                    child: CircularProgressIndicator(
                                      color: Colors.blue,
                                    )),
                                Text(
                                  "Loading...",
                                  style:
                                      TextStyle(fontSize: 18, color: Colors.black),
                                ),
                              ]);




                          //if item not found show the screen
                        case UserNotFoundState:
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "No User Found",
                                  style:
                                      TextStyle(fontSize: 18, color: Colors.black),
                                ),
                              ]);


                          //for not matching state found
                        default:
                          return Text(
                            "nothing",
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          );
                      }
                    },
                  ),
                ),

                //for all  text profile data
              ],
            ),
          ),
        ),

        floatingActionButton: FloatingActionButton(onPressed: ()=>{
// s
          Navigator.push( context, MaterialPageRoute( builder: (context) => CounterS()), ).then((value) => setState(() {}))

        // userBloc.add(UserShowErrorEvent("hello")),

        }
          ,
        child:Icon(Icons.arrow_circle_right_rounded)
        ),
      ),
    );
  }



  //all widget parts here
  Widget partnerDataWidget(User partner) {
    return GestureDetector(
      onTap: () {
        // partnerBloc.add(PartnerViewedEvent(partner.id));

        // Navigator.push( context, MaterialPageRoute( builder: (context) => UserProfile(user:partner)), ).then((value) => setState(() {}));
        // go to person widget
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => UserProfile(user: partner)),
        // );
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        margin: EdgeInsets.only(left: 15, right: 15, top: 15),


        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              height: 50,
              child: Icon(Icons.image),
            ),

            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    partner.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    partner.email,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    partner.phone,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    partner.website,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ],
              ),
            ) // Button text
          ],
        ),
      ),
    );
  }



  Widget SearchBarCustom() {
    return Container(
      height: 50,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.only(left: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 2, color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
        child: TextField(
          controller: _searchController,
          onChanged: (value) => applySearch(value),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.grey),
            suffixIcon: Icon(Icons.search, color: Colors.black),
          ),
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
      ),
    );

  }
  Widget SearchBarCustom2() {
    return Visibility(
      visible: isBarEnable,
      child: Container(
        width: double.infinity,
        color: Colors.indigoAccent,
        child: Row(
          children: [
             IconButton(icon:Icon(Icons.arrow_back,color: Colors.white,size: 22,),onPressed: enableDisableSearchbar),

            Expanded(
              flex: 1,
              child: TextField(
                controller: _searchController,
                onChanged: (value) => applySearch(value),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: CupertinoColors.systemGrey5),

                    suffixIcon:IconButton(icon:Icon(Icons.close,color: Colors.white,size: 22,),onPressed: ()=>{
                      _searchController.clear(),
                      applySearch(""),
                    }),

                  //onclick show SearchBar
                ),
                style: TextStyle(color: CupertinoColors.systemGrey5, fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );

  }

  Widget appBarCustom() {
    //app Bar
    return Visibility(
      visible: ! isBarEnable,
      child: Container(
        color: Colors.indigoAccent,
        padding: EdgeInsets.all(4),
        child: Row(
          children: [
            SizedBox(width: 10,),
            Expanded(
              flex: 1,
              child: Text(
                "Users",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),

            //onclick show SearchBar
            IconButton(icon:Icon(Icons.search,color: Colors.white,size: 24,),onPressed: enableDisableSearchbar,),

          ],
        ),
      ),
    );

  }

}
