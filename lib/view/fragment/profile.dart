import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weorganize/model/user.dart';
import 'package:weorganize/view/editprofile.dart';

import '../../service/services.dart';
import '../../utils/helper.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  late UserApiService apiService;
  FirebaseAuth auth = FirebaseAuth.instance;
  late UsersModel users;

  @override
  void initState() {
    super.initState();
    apiService = UserApiService();
  }
  
  
  @override
  Widget build(BuildContext context) {
    User? user = auth.currentUser;
    var uid = user?.uid;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<UsersModel?>(
        future: apiService.getUserBy(uid),
        builder: (BuildContext context, snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text(
                "Something wrong with message: ${snapshot.error.toString()}",
                textAlign: TextAlign.center,
              ),
            );
          }
          else if(snapshot.connectionState == ConnectionState.done && snapshot.data!= null){
            users = snapshot.data!;
            if(users.id_user.length >= 10){
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 115,
                      width: 115,
                      child: Stack(
                        fit: StackFit.expand,
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(users.picture),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      users.role,
                      style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    const SizedBox(height: 20),
                    ProfileMenu(
                      text: users.name,
                      icon: Icons.person_outline_outlined,
                      press: () => {},
                    ),
                    ProfileMenu(
                      text: users.email,
                      icon: Icons.email_outlined,
                      press: () {},
                    ),
                    ProfileMenu(
                      text: users.address,
                      icon: Icons.map_outlined,
                      press: () {},
                    ),
                    ProfileMenu(
                      text: DateFormat("dd MMMM yyyy").format(DateTime.parse(users.date_of_birth)),
                      icon: Icons.date_range_outlined,
                      press: () {},
                    ),
                    ProfileMenu(
                      text: users.telephone,
                      icon: Icons.phone,
                      press: () {},
                    ),
                  ],
                ),
              );
            }else{
              return const Text("User Not Found");
            }
          }else{
            return Center(
              child: Container(),
            );
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15, right: 15),
        child: FloatingActionButton(
          elevation: 15,
          onPressed: () {
            editProfile();
          },
          child: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  void editProfile() {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => EditProfile(users: users))
    );
  }
}
