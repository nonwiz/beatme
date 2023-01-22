import 'dart:convert';

import 'package:beatme/data/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  static late SharedPreferences prefs;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future writeSession(Session session) async {
    prefs.setString(session.id.toString(), json.encode(session.toJson()));
  }

  List<Session> getSession() {
    List<Session> sessions = [];
    Set<String> keys = prefs.getKeys();
    keys.forEach((String key) {
      if (key != 'counter') {
        Session session =
            Session.fromJson(json.decode(prefs.getString(key) ?? ''));
        sessions.add(session);
      }
    });
    return sessions;
  }

  Future deleteSession(int id) async {
    await prefs.remove(id.toString());
  }

  Future updateCounter() async {
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    await prefs.setInt('counter', counter);
  }

  int getCounter() {
    return prefs.getInt('counter') ?? 0;
  }
}
