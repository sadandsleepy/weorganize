import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weorganize/model/events.dart';
import 'package:weorganize/view/eventdetails.dart';
import '../../service/services.dart';

class Event extends StatefulWidget {
  const Event({Key? key}) : super(key: key);

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  late EventApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = EventApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: apiService.getEvent(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}",
                textAlign: TextAlign.center,
              ),
            );
          }
          else if(snapshot.connectionState == ConnectionState.done){
            List<EventsModel> events = snapshot.data as List<EventsModel>;
            return Center(
              child: Column(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text("Acara yang sedang berlangsung!.",
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
                    child: _buildListView(events),
                  )
                ],
              ),
            );
          }else{
            return Center(
              child: Container(),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(List<EventsModel> events) {
    return RefreshIndicator(
      onRefresh: pullRefresh,
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int i) => const Divider(color: Colors.white,),
        itemCount: events.length,
        itemBuilder: (context, index) {
          EventsModel event = events[index];
          return GestureDetector(
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => EventDetails(id: int.parse(event.id_event))
                    )
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
                      flex: 1,
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          margin: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Image.network(event.picture, width: 75, height: 75,),
                          )
                      ),
                    ),
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
                                    event.event_name,
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
                                    DateFormat("dd MMMM yyyy").format(DateTime.parse(event.event_date)),
                                    style: const TextStyle(
                                        fontSize: 10),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    event.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ]
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              )
          );
        },
      ),
    );
  }

  Future<void> pullRefresh() async  {
    setState(() {});
  }
}
