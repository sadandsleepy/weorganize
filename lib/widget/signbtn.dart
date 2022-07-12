import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/auth.dart';
import '../utils/helper.dart';

class SignBtn extends StatefulWidget {
  const SignBtn({Key? key}) : super(key: key);

  @override
  State<SignBtn> createState() => _SignBtnState();
}

class _SignBtnState extends State<SignBtn> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      )
          : OutlinedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () async {
              setState(() {
                _isSigningIn = true;
              });
              User? user = await Authentication.signInWithGoogle(context: context);
              setState(() {
                _isSigningIn = false;
              });
              setupCheck(user, context);
            },
            child: const FractionallySizedBox(
              alignment: Alignment.topCenter,
              widthFactor: 0.5,
                child: ClipRRect(
                    child: Image(
                    image: AssetImage('assets/imgs/gsign1.png')
                  )
                )
            ),
          ),
    );
  }
}