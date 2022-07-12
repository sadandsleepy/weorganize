import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../model/attendance.dart';
import '../model/user.dart';
import '../model/events.dart';

class UserApiService {

  final String baseUrl = "https://weorganize.niobesad.xyz";
  Client client = Client();

  Future<List<UsersModel>> getUsers() async {
    final response = await client.get(Uri.parse("$baseUrl/user"));
    if (response.statusCode == 200) {
      return userFromJson(response.body);
    } else {
      return [];
    }
  }

  Future<bool> createUser(UsersModel data) async {
    final response = await client.post(
        Uri.parse("$baseUrl/user"),
        body: {
          "id_user" : data.id_user,
          "name" : data.name,
          "email" : data.email,
          "picture" : data.picture,
          "address" : data.address,
          "date_of_birth" : data.date_of_birth,
          "telephone" : data.telephone,
          "role": data.role,
          "creation_date" : data.creation_date,
          "update_date" : data.update_date
        }
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<UsersModel?> getUserBy(String? id) async {
    final response = await client.get(
        Uri.parse("$baseUrl/user/$id")
    );
    if (response.statusCode == 200) {
      final data = UsersModel.fromJson(json.decode(response.body));
      return data;
    } else {
      return null;
    }
  }

  Future<bool> updateUser({required String id, required UsersModel data}) async {
    final response = await client.post(
        Uri.parse("$baseUrl/userupdate/1"),
        body: {
          "id_user" : id,
          "name" : data.name,
          "email" : data.email,
          "picture" : data.picture,
          "address" : data.address,
          "date_of_birth" : data.date_of_birth,
          "telephone" : data.telephone,
          "role" : data.role,
          "creation_date" : data.creation_date,
          "update_date" : data.update_date
        }
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> deleteUser({required int id}) async {
    final response = await client.delete(
        Uri.parse("$baseUrl/user/$id")
    );
    if (response.statusCode == 200) {
      return 1;
    } else {
      return 0;
    }
  }
}

class EventApiService {
  final String baseUrl = "https://weorganize.niobesad.xyz";
  Client client = Client();

  Future<List<EventsModel>> getEvent() async {
    final response = await client.get(Uri.parse("$baseUrl/event"));
    if (response.statusCode == 200) {
      return eventFromJson(response.body);
    } else {
      return [];
    }
  }

  Future<bool> createEvent(EventsModel data) async {
    final response = await client.post(
        Uri.parse("$baseUrl/event"),
        body: {
          "id_user" : data.id_user,
          "event_name" : data.event_name,
          "event_date" : data.event_date,
          "description" : data.description,
          "quota" : data.quota,
          "quota_amount" : data.quota_amount,
          "picture" : data.picture,
          "status" : data.status
        }
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<EventsModel?> getEventBy(int id) async {
    final response = await client.get(
        Uri.parse("$baseUrl/event/$id")
    );
    if (response.statusCode == 200) {
      final data = EventsModel.fromJson(json.decode(response.body));
      return data;
    } else {
      return null;
    }
  }

  Future<bool> updateEvent({required String id, required EventsModel data}) async {
    final response = await client.post(
        Uri.parse("$baseUrl/eventupdate/1"),
        body: {
          "id_event" : id,
          "id_user" : data.id_user,
          "event_name" : data.event_name,
          "event_date" : data.event_date,
          "description" : data.description,
          "quota" : data.quota,
          "quota_amount" : data.quota_amount,
          "picture" : data.picture,
          "status" : data.status
        }
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> deleteEvent({required int id}) async {
    final response = await client.delete(
        Uri.parse("$baseUrl/event/$id")
    );
    if (response.statusCode == 200) {
      return 1;
    } else {
      return 0;
    }
  }
}

class AttendanceApiService {
  final String baseUrl = "https://weorganize.niobesad.xyz";
  Client client = Client();

  Future<List<AttendancesModel>> getEvent() async {
    final response = await client.get(Uri.parse("$baseUrl/attendance"));
    if (response.statusCode == 200) {
      return attendFromJson(response.body);
    } else {
      return [];
    }
  }

  Future<bool> createAtt(AttendancesModel data) async {
    final response = await client.post(
        Uri.parse("$baseUrl/attendance"),
        body: {
          "id_user": data.id_user,
          "id_event": data.id_event,
          "particpant_name": data.particpant_name,
          "event_name": data.event_name,
          "event_date": data.event_date,
          "status": data.status,
          "admission_time": data.admission_time,
          "creation_date": data.creation_date,
          "update_date": data.update_date
        }
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<AttendancesModel?> getAttBy(int id) async {
    final response = await client.get(
        Uri.parse("$baseUrl/attendance/$id")
    );
    if (response.statusCode == 200) {
      final data = AttendancesModel.fromJson(json.decode(response.body));
      return data;
    } else {
      return null;
    }
  }

  Future<AttendancesModel?> getAttStat(String id_user, String id_event) async {
    final response = await client.get(
        Uri.parse("$baseUrl/attendance/$id_user/$id_event")
    );
    if (response.statusCode == 200) {
      final data = AttendancesModel.fromJson(json.decode(response.body));
      return data;
    } else {
      return null;
    }
  }

  Future<bool> updateAtt({required int id, required AttendancesModel data}) async {
    final response = await client.put(
        Uri.parse("$baseUrl/attendance/$id"),
        body: {
          "id_user": data.id_user,
          "id_event": data.id_event,
          "particpant_name": data.particpant_name,
          "event_name": data.event_name,
          "event_date": data.event_date,
          "admission_time": data.admission_time,
          "creation_date": data.creation_date,
          "update_date": data.update_date
        }
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> deleteAtt({required int id}) async {
    final response = await client.delete(
        Uri.parse("$baseUrl/event/$id")
    );
    if (response.statusCode == 200) {
      return 1;
    } else {
      return 0;
    }
  }
}

class MyAttendanceApiService{

  final String baseUrl = "https://weorganize.niobesad.xyz";
  Client client = Client();

  Future<List<AttendancesModel>> getAtt(String id) async {
    final response = await client.get(Uri.parse("$baseUrl/myatt/$id"));
    if (response.statusCode == 200) {
      return attendFromJson(response.body);
    } else {
      return [];
    }
  }
}