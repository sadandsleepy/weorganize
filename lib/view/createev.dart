import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weorganize/service/services.dart';
import 'package:weorganize/utils/helper.dart';
import 'dart:io';
import '../model/events.dart';
import 'dashboard.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  late DateTime dateTime;
  String time = DateFormat("dd MMMM yyyy").format(DateTime.now()).toString();
  FirebaseAuth auth = FirebaseAuth.instance;
  final storageRef = FirebaseStorage.instance.ref();

  TextEditingController judul = TextEditingController();
  TextEditingController deskripsi = TextEditingController();

  late EventApiService eventApiService;

  File? imageFile;
  List<String> getData = [];
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    eventApiService = EventApiService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Event",
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
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/imgs/bg5.png"),
              fit: BoxFit.cover,
            ),
          ),
          child : Container(
            height: 550,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: Color(0xff64D2AE),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                )
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      child: const Text('Buat Acara Baru',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Open Sans',
                              fontSize: 25)
                      )
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text('Tanggal',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Open Sans',
                            fontSize: 15)
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () async {
                      DateTime? pickDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2030)
                      );
                      if (pickDate != null){
                        setState(() {
                          time = DateFormat("dd MMMM yyyy").format(pickDate);
                          dateTime = pickDate;
                        });
                      }
                    },
                    child: Container(
                        width: 150,
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(time,
                              style: const TextStyle(
                                  color : Colors.white
                              ),
                            ),
                            const Icon(
                              Icons.calendar_month,
                              color: Colors.white,
                            ),
                          ],
                        )
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text('Judul Acara',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Open Sans',
                            fontSize: 15)
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: TextField(
                        cursorColor: Colors.white,
                        controller: judul,
                        decoration: const InputDecoration.collapsed(
                          hintText: "Judul",
                          hintStyle:TextStyle(
                              fontSize: 15.0,
                              color: Colors.white),
                        ),
                      )
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text('Deskripsi Acara',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Open Sans',
                            fontSize: 15)
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                      height: 150,
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 100,
                        cursorColor: Colors.white,
                        controller: deskripsi,
                        decoration: const InputDecoration.collapsed(
                          hintText: "Deskripsi",
                          hintStyle:TextStyle(
                              fontSize: 15.0,
                              color: Colors.white),
                        ),
                      )
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text('Tambahkan Cover Acara',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Open Sans',
                            fontSize: 15)
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                      onTap: (){
                        checkPermission();
                      },
                      child: Image(
                        image: setupImage(),
                        height: 50,
                        width: 50,
                      )
                  )
                ],
              ),
            )
          )

        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          elevation: 15,
          onPressed: () {
            validate();
          },
          child: const Icon(
            Icons.save,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  void validate() {
    time.isEmpty ||
        judul.text.isEmpty ||
        deskripsi.text.isEmpty ||
        imageFile == null
        ? toast("Please fill all the form to continue")
        : onLoad();
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
        Navigator.pop(context); //pop dialog
        await saveData().then((value) => goHome());
    }
    );
  }

  Future checkPermission() async{
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
        ? const AssetImage('assets/icons/ico1.png')
        : FileImage(imageFile!);
  }

  Future<void> saveData() async {
    String name = DateFormat("yyyy-MM-dd:h:m:s").format(DateTime.now()).toString();
    Reference imagesRef = storageRef.child("images/event/$name.jpg");
    UploadTask uploadTask = imagesRef.putFile(imageFile!);

    await uploadTask.whenComplete(() async {
      var url = await uploadTask.snapshot.ref.getDownloadURL();
      uploadWeb(url);
    });

  }

  goHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const Dashboard(role:'organizer')
        ));
  }

  uploadWeb(String url) {
    String timeFormat = DateFormat("yyyy-MM-dd").format(dateTime);
    User? user = auth.currentUser;
    var uid = user?.uid;

    EventsModel event = EventsModel(
        id_event: '',
        id_user: '',
        event_name: '',
        event_date: '',
        description: '',
        quota: '',
        quota_amount: '',
        picture: '',
        status: '',

    );

    event.id_user = uid!;
    event.event_name = judul.text;
    event.event_date = timeFormat;
    event.description = deskripsi.text;
    event.quota = "150";
    event.quota_amount = "0";
    event.picture = url;
    event.status = "available";

    eventApiService.createEvent(event).then((value) => toast("Event Created"));
  }

}
