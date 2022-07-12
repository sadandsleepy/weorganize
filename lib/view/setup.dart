import 'package:flutter/material.dart';
import 'package:weorganize/view/setconf.dart';

class Setup extends StatefulWidget {
  const Setup({Key? key}) : super(key: key);

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {


  @override
  void initState() {
    super.initState();
  }
  
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
              const Text("First thing first, let me know who you are",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                  height: 50
              ),
              OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const ConfirmData(role : "organizer"),
                      )
                  );
                },
                child: const Text('I am a Organizer',
                    style: TextStyle(fontSize: 25)
                ),
              ),
              OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ConfirmData(role : "participant"),
                      )
                  );
                },
                child: const Text('I am a Participant',
                    style: TextStyle(fontSize: 25)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
