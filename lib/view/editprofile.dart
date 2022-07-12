import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weorganize/model/user.dart';
import 'dart:io';
import 'package:weorganize/service/services.dart';
import '../utils/helper.dart';
import 'dashboard.dart';


class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.users}) : super(key: key);

  final UsersModel users;
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  FirebaseAuth auth = FirebaseAuth.instance;
  final storageRef = FirebaseStorage.instance.ref();

  late DateTime dateTime;
  late String time;

  TextEditingController nametxt = TextEditingController();
  TextEditingController emailtxt = TextEditingController();
  TextEditingController phonetxt = TextEditingController();
  TextEditingController addresstxt = TextEditingController();

  File? imageFile;
  List<String> getData = [];
  final ImagePicker picker = ImagePicker();

  late UserApiService userApiService;

  @override
  void initState(){
    time = DateFormat("dd MMMM yyyy").format(DateTime.parse(widget.users.date_of_birth));
    dateTime = DateTime.parse(widget.users.date_of_birth);
    userApiService = UserApiService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    nametxt.text = widget.users.name;
    emailtxt.text = widget.users.email;
    phonetxt.text = widget.users.telephone;
    addresstxt.text = widget.users.address;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Edit Profile",
            style: TextStyle(
                color: Colors.green
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.green
            ),
            onPressed: () => {
              Navigator.pop(context),
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                  Icons.check_outlined,
                  color: Colors.green
              ),
              onPressed: () => {
                onLoad(),
              },
            ),
          ],
        ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                    backgroundImage: setupImage(),
                  ),
                  Positioned(
                    right: -16,
                    bottom: 0,
                    child: SizedBox(
                      height: 46,
                      width: 46,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: const BorderSide(color: Colors.white),
                          ),
                          primary: Colors.white,
                          backgroundColor: const Color(0xFFF5F6F9),
                        ),
                        onPressed: () {
                          checkPermission();
                        },
                        child: const Icon(Icons.camera_alt_rounded),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.person_outline,
                      color: Colors.black12,
                      size: 22,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                        child: TextField(
                          cursorColor: Colors.white,
                          controller: nametxt,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            hintText: widget.users.name,
                            hintStyle:const TextStyle(
                                fontSize: 15.0,
                                color: Colors.black),
                          ),
                        )
                    )
                  ],
                ),
              )
            ),
            const SizedBox(height: 20),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.email_outlined,
                        color: Colors.black12,
                        size: 22,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                          child: TextField(
                            cursorColor: Colors.white,
                            controller: emailtxt,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                              hintText: widget.users.email,
                              hintStyle:const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black),
                            ),
                          )
                      )
                    ],
                  ),
                )
            ),
            const SizedBox(height: 20),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.map_outlined,
                        color: Colors.black12,
                        size: 22,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                          child: TextField(
                            cursorColor: Colors.white,
                            controller: addresstxt,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                              hintText: widget.users.address,
                              hintStyle:const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black),
                            ),
                          )
                      )
                    ],
                  ),
                )
            ),
            const SizedBox(height: 20),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.date_range_outlined,
                        color: Colors.black12,
                        size: 22,
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                          child: GestureDetector(
                            onTap: (){
                              pickDate();
                            },
                            child: Text(
                              time.toString(),
                              style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black),
                            ),
                          )
                      )
                    ],
                  ),
                )
            ),
            const SizedBox(height: 20),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.phone_enabled_outlined,
                        color: Colors.black12,
                        size: 22,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                          child: TextField(
                            cursorColor: Colors.white,
                            controller: phonetxt,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                              hintText: widget.users.telephone,
                              hintStyle:const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black),
                            ),
                          )
                      )
                    ],
                  ),
                )
            ),
          ],
        ),
      )
    );
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
        const Duration(seconds: 5), () async {
          Navigator.pop(context);
          await saveData().then((value) => goHome());
        }
    );
  }

  Future<void> saveData() async  {
    String name = DateFormat("yyyy-MM-dd:h:m:s").format(DateTime.now()).toString();
    Reference imagesRef = storageRef.child("images/profile/$name.jpg");
    if(imageFile != null){
      UploadTask uploadTask = imagesRef.putFile(imageFile!);
      await uploadTask.whenComplete(() async{
        var url = await uploadTask.snapshot.ref.getDownloadURL();
        uploadWeb(url);
      });
    }else{
      uploadWeb(widget.users.picture);
    }
  }

  uploadWeb(String url){
    String timeFormat = DateFormat("yyyy-MM-dd").format(dateTime);
    String dateNow = DateFormat("yyyy-MM-dd").format(DateTime.now());
    User? user = auth.currentUser;
    var uid = user?.uid;

    UsersModel users = UsersModel(
        id_user: 'id_user',
        name: 'name',
        email: 'email',
        picture: 'picture',
        address: 'address',
        date_of_birth: 'date_of_birth',
        telephone: 'telephone',
        role: 'role',
        creation_date: 'creation_date',
        update_date: 'update_date'
    );

    users.name = nametxt.text;
    users.email = emailtxt.text;
    users.address = addresstxt.text;
    users.picture = url;
    users.date_of_birth = timeFormat;
    users.telephone = phonetxt.text;
    users.role = widget.users.role;
    users.creation_date = widget.users.creation_date;
    users.update_date = dateNow;


    userApiService.updateUser(
        id: uid!,
        data: users
    ).then((value) => toast("Profile Updated"));
  }

  Future<void> pickDate() async {
    DateTime? pickDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2030)
    );
    if (pickDate != null){
      setState(() {
        time = DateFormat("dd MMMM yyyy").format(pickDate);
        dateTime = pickDate;
      });
    }
  }

  void checkPermission() async{
    var status = await Permission.storage.status;

    if(status.isDenied){
      Permission.storage.request().whenComplete(() => getFromGallery());
    }else{
      getFromGallery();
    }
  }

  getFromGallery() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery,
      maxWidth: 900,
      maxHeight: 900,);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  setupImage() {
    return imageFile == null
        ? NetworkImage(widget.users.picture)
        : FileImage(imageFile!);
  }

  goHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => Dashboard(role: widget.users.role)
        ));
  }
}
