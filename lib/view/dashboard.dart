import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weorganize/utils/helper.dart';
import 'package:weorganize/view/fragment/event.dart';
import 'package:weorganize/view/fragment/home.dart';
import 'package:weorganize/view/fragment/homeorg.dart';
import 'package:weorganize/view/fragment/profile.dart';
import 'package:weorganize/view/fragment/history.dart';
import 'package:weorganize/view/signup.dart';


class Dashboard extends StatefulWidget {
  final String role;
  const Dashboard({Key? key, required this.role}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  FirebaseAuth auth = FirebaseAuth.instance;
  int _selectedIndex = 0;
  PageStorageBucket bucket =  PageStorageBucket();
  Widget screenState = const Home();
  String tittle = "Home";

  @override
  void initState() {
    super.initState();
    if (widget.role == 'organizer'){
      screenState = const HomeOrg();
    }else{
      screenState = const Home();
    }
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index){
      case 0:
        if (widget.role == 'organizer'){
          screenState = const HomeOrg();
        }else{
          screenState = const Home();
        }
        tittle = "Home";
        //toast("Home");
        break;
      case 1:
        screenState = const Event();
        tittle = "Event";
        //toast("Event");
        break;
      case 2:
        screenState = const History();
        tittle = "History";
        //toast("History");
        break;
      case 3:
        screenState = const Profile();
        tittle = "Profile";
        //toast("Profile");
        break;
    }
  }
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(),
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              tittle,
              style: const TextStyle(
                  color: Colors.green
              ),
            ),
            centerTitle: true,
            leading: selIcon(),
            actions: [
              selAction()
            ],
          ),
          backgroundColor: Colors.white,
          body: PageStorage(
            bucket: bucket,
            child: screenState,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            iconSize: 27,
            selectedFontSize: 15,
            selectedIconTheme: const IconThemeData(
                color: Color(0xff64D2AE),
                size: 35),
            selectedItemColor: const Color(0xff64D2AE),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: "Home"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.event),
                  label: "Event"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: "History"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile"
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        )
    );
  }

  selIcon() {
    if(tittle == "Home"){
      return IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: const Icon(
            Icons.menu_sharp,
            color: Colors.green
        ),
        onPressed: () {

        },
      );
    }else{
      return Container();
    }
  }

  selAction() {

    if(tittle == "Profile"){
      return IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: const Icon(
            Icons.logout_outlined,
            color: Colors.green
        ),
        onPressed: () {
          auth.signOut().then((value) => goHome());
        },
      );
    }else{
      return Container();
    }
  }

  goHome() {
    toast("Logged out.");
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const SignUp()
        )
    );
  }
}
