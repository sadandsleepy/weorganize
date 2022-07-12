import 'dart:convert';

class EventsModel {

  String id_event;
  String id_user;
  String event_name;
  String event_date;
  String description;
  String quota;
  String quota_amount;
  String picture;
  String status;

  EventsModel(
      {required this.id_event,
        required this.id_user,
        required this.event_name,
        required this.event_date,
        required this.description,
        required this.quota,
        required this.quota_amount,
        required this.picture,
        required this.status});

  factory EventsModel.fromJson(Map<String, dynamic> map){
    return EventsModel(
      id_event: map["id_event"],
      id_user: map["id_user"],
      event_name: map["event_name"],
      event_date: map["event_date"],
      description: map["description"],
      quota: map["quota"],
      quota_amount: map["quota_amount"],
      picture: map["picture"],
      status: map["status"],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      "id_event": id_event,
      "id_user": id_user,
      "event_name": event_name,
      "event_date": event_date,
      "description": description,
      "quota": quota,
      "quota_amount": quota_amount,
      "picture": picture,
      "status": status,
    };
  }

  @override
  String toString(){
    return 'Events{id_event: $id_event, id_user: $id_user, quota: $quota, quota_amount: $quota_amount, picture: $picture, event_date: $event_date, status: $status, description: $description, event_name: $event_name}';
  }
}

List<EventsModel> eventFromJson(String jsonData){
  final data = json.decode(jsonData);
  return List<EventsModel>.from(data.map((item) => EventsModel.fromJson(item)));
}

String eventToJson(EventsModel data){
  final jsonData = data.toJson();
  return json.encode(jsonData);
}