import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weorganize/model/attendance.dart';
import 'package:weorganize/service/services.dart';
import 'package:weorganize/view/eventdetails.dart';

import '../../utils/helper.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late MyAttendanceApiService apiService;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    apiService = MyAttendanceApiService();
  }

  @override
  Widget build(BuildContext context) {
    User? user = auth.currentUser;
    var iduser = user?.uid;

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: apiService.getAtt(iduser!),
          builder: (BuildContext context, snapshot){
            if(snapshot.hasError){
              return Center(
                child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}",
                  textAlign: TextAlign.center,
                ),
              );
            }
            else if(snapshot.connectionState == ConnectionState.done && snapshot.data!= null){
              List<AttendancesModel> attendance = snapshot.data as List<AttendancesModel>;
              return Center(
                child: Column(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text("Acara Yang Anda Ikuti!.",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w100,
                            fontFamily: 'Open Sans',
                            fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Expanded(
                      flex: 20,
                      child: _buildListView(attendance),
                    )
                  ],
                ),
              );
            }else{
              return Center(
                child: Container(
                ),
              );
            }
          }
      )
    );
  }
  Widget _buildListView(List<AttendancesModel> attendance) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int i) => const Divider(color: Colors.white,),
        itemCount: attendance.length,
        itemBuilder: (context, index){
          AttendancesModel attendances = attendance[index];
          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => EventDetails(id: int.parse(attendances.id_event)))
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children : [
                                Text(
                                  attendances.event_name,
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  DateFormat("dd MMMM yyyy").format(DateTime.parse(attendances.event_date)),
                                  style: const TextStyle(
                                      fontSize: 10),
                                ),
                              ]
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}


