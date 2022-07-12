import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weorganize/utils/helper.dart';
import '../model/events.dart';
import '../service/services.dart';
import 'dart:io';

import 'dashboard.dart';

class EditEvent extends StatefulWidget {
  const EditEvent({Key? key, required this.event}) : super(key: key);

  final EventsModel event;
  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {

  late DateTime dateTime;
  late String time;
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
    time = DateFormat("dd MMMM yyyy").format(DateTime.parse(widget.event.event_date)).toString();
    dateTime = DateTime.parse(widget.event.event_date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    judul.text = widget.event.event_name;
    deskripsi.text = widget.event.description;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Event",
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
      body: Container(
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
                      child: const Text('Perbahrui Eventmu!',
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
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(time,
                              style: const TextStyle(
                                  color : Colors.black
                              ),
                            ),
                            const Icon(
                              Icons.calendar_month,
                              color: Colors.black,
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
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white
                      ),
                      child: TextField(
                        cursorColor: Colors.black,
                        controller: judul,
                        decoration: const InputDecoration.collapsed(
                          hintText: "Judul",
                          hintStyle:TextStyle(
                              fontSize: 15.0,
                              color: Colors.black),
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
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white
                      ),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 100,
                        cursorColor: Colors.black,
                        controller: deskripsi,
                        decoration: const InputDecoration.collapsed(
                          hintText: "Deskripsi",
                          hintStyle:TextStyle(
                              fontSize: 15.0,
                              color: Colors.black),
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
            ),
          )

      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          elevation: 15,
          onPressed: () {
            onLoad();
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
        const Duration(seconds: 2), () async {
        Navigator.pop(context); //pop dialog
        await saveData().then((value) => goHome());
    }
    );
  }

  Future<void> saveData() async {
    String name = DateFormat("yyyy-MM-dd:h:m:s").format(DateTime.now()).toString();
    Reference imagesRef = storageRef.child("images/event/$name.jpg");

    if(imageFile != null){
      UploadTask uploadTask = imagesRef.putFile(imageFile!);
      await uploadTask.whenComplete(() async {
        var url = await uploadTask.snapshot.ref.getDownloadURL();
        uploadWeb(url);
      });
    }else{
      uploadWeb(widget.event.picture);
    }

  }

  Future checkPermission() async{
    var status = await Permission.storage.status;

    if(status.isDenied){
      Permission.storage.request().whenComplete(() => getFromGallery());
    }else{
      getFromGallery();
    }
  }

  getFromGallery()async {
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
        ? NetworkImage(widget.event.picture)
        : FileImage(imageFile!);
  }

  void uploadWeb(String url) {
    String timeFormat = DateFormat("yyyy-MM-dd").format(dateTime);
    User? user = auth.currentUser;
    var uid = user?.uid;

    EventsModel events = EventsModel(
        id_event: 'id_event',
        id_user: 'id_user',
        event_name: 'event_name',
        event_date: 'event_date',
        description: 'description',
        quota: 'quota',
        quota_amount: 'quota_amount',
        picture: 'picture',
        status: 'status');

    events.id_event = widget.event.id_event;
    events.id_user = uid!;
    events.event_name = judul.text;
    events.event_date = timeFormat;
    events.description = deskripsi.text;
    events.quota = widget.event.quota;
    events.quota_amount = widget.event.quota_amount;
    events.picture = url;
    events.status = widget.event.status;

    eventApiService.updateEvent(
        id: widget.event.id_event,
        data: events
    ).then((value) => toast("Event Updated."));

  }

  goHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const Dashboard(role: 'organizer')
        ));
  }
}
