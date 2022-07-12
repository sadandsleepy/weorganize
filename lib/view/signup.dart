import 'package:flutter/material.dart';
import 'package:weorganize/utils/auth.dart';
import 'package:weorganize/widget/signbtn.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}


class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(0xff64D2AE),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100)
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image (
                image: AssetImage('assets/imgs/bg3.png'),
              ),
              const SizedBox(
                  height: 150
              ),
              FutureBuilder(
                future: Authentication.initializeFirebase(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Error initializing Firebase');
                  }else if (snapshot.connectionState == ConnectionState.done) {
                    return const SignBtn();
                  }
                  return const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  );
                },
              )
            ],
          ),
        ),

      ),
    );
  }
}

