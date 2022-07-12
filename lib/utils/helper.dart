import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../view/dashboard.dart';
import '../view/eventdetails.dart';
import '../view/setup.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black,
          padding: const EdgeInsets.all(20),
          shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.green,
              size: 22,
            ),
            const SizedBox(width: 20),
            Expanded(
                child: Text(text)
            )
          ],
        ),
      ),
    );
  }
}

Future<bool?> toast (msg){
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

Future<DocumentSnapshot<Map<String, dynamic>>> checkDoc(String docId) async {
  try {
    var doc = await FirebaseFirestore.instance.collection('Users').doc(docId).get();
    return doc;
  } catch (e) {
    rethrow;
  }
}

RichText richText(String msg){
  return RichText(
    overflow: TextOverflow.ellipsis,
    strutStyle: const StrutStyle(fontSize: 25),
    text:  TextSpan(
        style: const TextStyle(color: Colors.black),
        text: msg.length > 20 ? '${msg.substring(0, 32)}...' : msg),
  );
}

void setupCheck(user, context) async {
  var dat = await checkDoc(user.uid);
  if (dat.exists){
    Map<String, dynamic> data = dat.data()!;
    String name = data['role'];
    if(name == 'participant'){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Dashboard(role : 'participant'),
          )
      );
    }
    else if(name == 'organizer'){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Dashboard(role : 'organizer'),
          )
      );
    }
  }
  else{
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const Setup()
        )
    );
  }
}

void goEvent(id, context){
  Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => EventDetails(id: id)
      )
  );
}