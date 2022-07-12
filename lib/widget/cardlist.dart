import 'package:flutter/material.dart';
import 'package:weorganize/utils/helper.dart';

class Item1 extends StatelessWidget {
  const Item1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        goEvent(20008, context);
      },
      child: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage("https://temumaya.id/uploads/flyer/resize_78654805262a1540a215fd.jpg"),
                fit: BoxFit.cover
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            Text(
                "Creativepreneur : Innovation Begins From You",
                style: TextStyle(
                    color: Color(0xff64D2AE),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(-1.5, 1.5),
                          blurRadius: 15
                      ),
                      Shadow(
                          color: Colors.black,
                          offset: Offset(1.5, 1.5),
                          blurRadius: 15
                      ),
                      Shadow(
                          color: Colors.black,
                          offset: Offset(-1.5, -1.5),
                          blurRadius: 15
                      ),
                      Shadow(
                          color: Colors.black,
                          offset: Offset(-1.5, 1.5),
                          blurRadius: 15
                      ),

                    ]
                )
            ),
          ],
        ),
      ),
    );
  }
}

class Item2 extends StatelessWidget {
  const Item2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        goEvent(20009, context);
      },
      child: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage("https://temumaya.id/uploads/flyer/resize_21122713336299ab7cea0a0.jpg"),
                fit: BoxFit.cover
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            Text(
                "The Role of Youth in Preventing Drug Abuse",
                style: TextStyle(
                    color: Color(0xff64D2AE),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(-1.5, 1.5),
                          blurRadius: 10
                      ),
                      Shadow(
                          color: Colors.black,
                          offset: Offset(1.5, 1.5),
                          blurRadius: 10
                      ),
                      Shadow(
                          color: Colors.black,
                          offset: Offset(-1.5, -1.5),
                          blurRadius: 10
                      ),
                      Shadow(
                          color: Colors.black,
                          offset: Offset(-1.5, 1.5),
                          blurRadius: 10
                      ),

                    ]
                )
            ),
          ],
        ),
      )
    );
  }
}

class Item3 extends StatelessWidget {
  const Item3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        goEvent(20010, context);
      },
      child: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage("https://temumaya.id/uploads/flyer/resize_114619017262a2771664afa.jpg"),
                fit: BoxFit.cover
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            Text(
                "Calibration & HACCP - Based Food Safety Systems",
                style: TextStyle(
                    color: Color(0xff64D2AE),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(-1.5, 1.5),
                          blurRadius: 10
                      ),
                      Shadow(
                          color: Colors.black,
                          offset: Offset(1.5, 1.5),
                          blurRadius: 10
                      ),
                      Shadow(
                          color: Colors.black,
                          offset: Offset(-1.5, -1.5),
                          blurRadius: 10
                      ),
                      Shadow(
                          color: Colors.black,
                          offset: Offset(-1.5, 1.5),
                          blurRadius: 10
                      ),

                    ]
                )
            ),
          ],
        ),
      ),
    );
  }
}

class Item4 extends StatelessWidget {
  const Item4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        goEvent(20011, context);
      },
      child: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage("https://temumaya.id/uploads/flyer/resize_161490833062a153379360d.jpg"),
                fit: BoxFit.cover
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            Text(
                "Urgensi dalam Memberikan Informasi dan Tuntunan kepada Calon Akuntan Muda",
                style: TextStyle(
                    color: Color(0xff64D2AE),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(-1.5, 1.5),
                          blurRadius: 10
                      ),
                      Shadow(
                          color: Colors.black,
                          offset: Offset(1.5, 1.5),
                          blurRadius: 10
                      ),
                      Shadow(
                          color: Colors.black,
                          offset: Offset(-1.5, -1.5),
                          blurRadius: 10
                      ),
                      Shadow(
                          color: Colors.black,
                          offset: Offset(-1.5, 1.5),
                          blurRadius: 10
                      ),
                    ]
                )
            ),
          ],
        ),
      ),
    );
  }
}