import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weorganize/service/services.dart';
import 'package:weorganize/utils/helper.dart';
import '../model/user.dart';
import 'dashboard.dart';

class ConfirmData extends StatefulWidget {
  const ConfirmData({Key? key, required this.role}) : super(key: key);

  final String role;

  @override
  State<ConfirmData> createState() => _ConfirmDataState();
}

class _ConfirmDataState extends State<ConfirmData> {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController instansi = TextEditingController();

  late UserApiService userApiService;

  bool rememberMe = false;
  void checkBoxCallBack(bool? checkBoxState) {
    if (checkBoxState != null) {
      setState(() {
        rememberMe = checkBoxState;
      });
    }
  }

  String emailValue = '';
  String nameValue = '';
  String phoneValue = '';

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    userApiService = UserApiService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? user = auth.currentUser;

    if(user != null){
      emailValue = user.email.toString();
      nameValue = user.displayName.toString();
      phoneValue = user.phoneNumber.toString();
    }

    email.value =  TextEditingValue(
      text: emailValue,
      selection: TextSelection.fromPosition(
        TextPosition(offset: emailValue.length),
      ),
    );

    name.value =  TextEditingValue(
      text: nameValue,
      selection: TextSelection.fromPosition(
        TextPosition(offset: nameValue.length),
      ),
    );


    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/imgs/bg4.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          height: 550,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Color(0xff64D2AE),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(75),
                topLeft: Radius.circular(75),
              )
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                alignment: Alignment.topLeft,
                child: const Text("Konfirmasi Data",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Open Sans',
                      fontSize: 25),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  cursorColor: Colors.white,
                  controller: email,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintText: "Email",
                    hintStyle:TextStyle(
                        fontSize: 15.0,
                        color: Colors.white),
                  ),
                )
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    cursorColor: Colors.white,
                    controller: name,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Nama",
                      hintStyle:TextStyle(
                          fontSize: 15.0,
                          color: Colors.white),
                    ),
                  )
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    cursorColor: Colors.white,
                    controller: phone,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Phone",
                      hintStyle:TextStyle(
                          fontSize: 15.0,
                          color: Colors.white),
                    ),
                  )
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: insText(),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                child: Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: checkBoxCallBack,
                    ),
                    const Text("Dengan melanjutkan pendaftaran anda setuju \ndengan syarat dan ketentuan yang berlaku.")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 15),
        child: FloatingActionButton(
          elevation: 15,
          onPressed: () {
            validate();
          },
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  void validate() {
    email.text.isEmpty ||
        name.text.isEmpty ||
        phone.text.isEmpty ||
        rememberMe == false
        ? toast("Please fill all the form and check the agreement to continue")
        : onLoad();
  }

  Future<void> uploadData() async {

    User? user = auth.currentUser;
    final users = FirebaseFirestore.instance.collection('Users').doc(user?.uid);

    final datList = {
      'uid' : user?.uid,
      'email' : email.text,
      'name' : name.text,
      'phone' : phone.text,
      'instansi' : instansi.text,
      'role' : widget.role
    };

    await users.set(datList)
    .then((value) =>
        goHome()
    )
    .catchError((error) => toast("Failed to add user: $error"));

  }

  goHome() {
    var role = widget.role;
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => Dashboard(role: role)
        ));
  }

  uploadWeb() {
    User? user = auth.currentUser;
    var uid = user?.uid;

    String time = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();

    UsersModel _user = UsersModel(
        picture: '',
        creation_date: '',
        address: '',
        name: '',
        id_user: '',
        email: '',
        date_of_birth: '',
        telephone: '',
        role: '',
        update_date: ''
    );

    _user.id_user = uid!;
    _user.name = name.text;
    _user.email = email.text;
    _user.picture = "https://via.placeholder.com/150";
    _user.address = "Jalan Raya";
    _user.date_of_birth = "1992-10-17";
    _user.telephone = phone.text;
    _user.role = widget.role;
    _user.creation_date = time;
    _user.update_date = time;

    userApiService.createUser(_user);
  }

  void onLoad() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 2,
                  ),
                  Text("Wait a second."),
                ],
              ),
            )
        );
      },
    );
    Future.delayed(
      const Duration(seconds: 1), () {
        Navigator.pop(context); //pop dialog
        uploadWeb();
        uploadData();
      }
    );
  }

  insText() {
    if(widget.role == "organizer"){
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextField(
            cursorColor: Colors.white,
            controller: instansi,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              hintText: "Instansi",
              hintStyle:TextStyle(
                  fontSize: 15.0,
                  color: Colors.white),
            ),
          )
      );
    }else{
      return Container();
    }
  }
}
