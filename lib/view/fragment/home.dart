import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/helper.dart';
import '../../widget/cardlist.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController search = TextEditingController();
  int _currentIndex=0;
  List cardList=[
    const Item1(),
    const Item2(),
    const Item3(),
    const Item4()
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  var name = '';

  @override
  Widget build(BuildContext context) {
    User? user = auth.currentUser;

    if(user != null){
      name = user.displayName.toString();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  bottom: 10,
                  top: 10,
                  left: 15,
                  right: 15
                ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Halo $name!,",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Open Sans',
                              fontSize: 25),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Ayo hadiri seminar di sekitarmu!.",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w100,
                              fontFamily: 'Open Sans',
                              fontSize: 20),
                        ),
                      ),
                    ],
                  )
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10)
                    )
                ),
                child: TextField(
                  cursorColor: Colors.white,
                  controller: search,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.only(top: 15),
                    border: InputBorder.none,
                    hintText: "Search",
                    hintStyle:TextStyle(
                        fontSize: 15.0,
                        color: Colors.black),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        bottom: 10,
                        left: 15,
                        right: 15
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Acara yang akan berlangsung",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Open Sans',
                            fontSize: 15),
                      ),
                    ),
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 250.0,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      pauseAutoPlayOnTouch: true,
                      aspectRatio: 4.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: cardList.map((card){
                      return Builder(
                          builder:(BuildContext context){
                            return SizedBox(
                              height: MediaQuery.of(context).size.height*0.30,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                color: Colors.white,
                                child: card,
                              ),
                            );
                          }
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(cardList, (index, url) {
                      return Container(
                        width: 10.0,
                        height: 10.0,
                        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: _currentIndex == index ? BoxShape.rectangle : BoxShape.circle,
                          color: _currentIndex == index ? const Color(0xff64D2AE) : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(
                    bottom: 10,
                    top: 10,
                    left: 15,
                    right: 15
                ),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Rekomendasi acara lainnya",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Open Sans',
                        fontSize: 15),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  right: 15,
                  left: 15,
                  top: 5,
                  bottom: 5,
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        goEvent(20002, context);
                      },
                      child: Column(
                        children: const [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("18 July 2022",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'Open Sans',
                                  fontSize: 10),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("SKRIPSI TUNTAS, NILAI BIKIN PUAS.",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
                    GestureDetector(
                      onTap: (){
                        goEvent(20004, context);
                      },
                      child: Column(
                        children: const [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("16 July 2022",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'Open Sans',
                                  fontSize: 10),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Reformasi Perpajakan Pasca Terbit UU HPP terhadap PPN dan NPWP pada Era Post-Pandemic.",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
                    GestureDetector(
                      onTap: (){
                        goEvent(20006, context);
                      },
                      child: Column(
                        children: const [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("02 July 2022",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'Open Sans',
                                  fontSize: 10),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Chinese 101 Calligraphy Workshop.",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
                    GestureDetector(
                      onTap: (){
                        goEvent(20007, context);
                      },
                      child: Column(
                        children: const [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("15 Juni 2022",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'Open Sans',
                                  fontSize: 10),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("LIFE AFTER CAMPUS PROGRAM.",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
