import 'dart:convert';

class AttendancesModel {

  String id_attendance;
  String id_user;
  String id_event;
  String particpant_name;
  String event_name;
  String event_date;
  String status;
  String admission_time;
  String creation_date;
  String update_date;


  AttendancesModel(
      {required this.id_attendance,
        required this.id_user,
        required this.id_event,
        required this.particpant_name,
        required this.event_name,
        required this.event_date,
        required this.status,
        required this.admission_time,
        required this.creation_date,
        required this.update_date});


  factory AttendancesModel.fromJson(Map<String, dynamic> map) {
    return AttendancesModel(
        id_attendance: map["id_attendance"],
        id_user: map["id_user"],
        id_event: map["id_event"],
        particpant_name: map["particpant_name"],
        event_name: map["event_name"],
        event_date: map["event_date"],
        status: map["status"],
        admission_time: map["admission_time"],
        creation_date: map["creation_date"],
        update_date: map["update_date"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_attendance": id_attendance,
      "id_user": id_user,
      "id_event": id_event,
      "particpant_name": particpant_name,
      "event_name": event_name,
      "event_date": event_date,
      "status" : status,
      "admission_time": admission_time,
      "creation_date": creation_date,
      "update_date": update_date
    };
  }

  @override
  String toString() {
    return 'Attendances{id_attendance: $id_attendance, id_user: $id_user, id_event: $id_event, particpant_name: $particpant_name, event_name: $event_name, event_date: $event_date, status: $status, admission_time: $admission_time, creation_date: $creation_date, update_date: $update_date,}';
  }
}

List<AttendancesModel> attendFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<AttendancesModel>.from(data.map((item) => AttendancesModel.fromJson(item)));
}

String attendToJson(AttendancesModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}