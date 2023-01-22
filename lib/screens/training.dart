import 'package:beatme/data/session.dart';
import 'package:beatme/data/sp_helper.dart';
import 'package:flutter/material.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({Key? key}) : super(key: key);

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtDuration = TextEditingController();
  final SPHelper helper = SPHelper();
  List<Session> sessions = [];

  @override
  void initState() {
    helper.init().then((value) {
      updateScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Training Sessions")),
      body: ListView(children: getContent()),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showSessionDialog(context);
          },
          child: Icon(Icons.add)),
    );
  }

  Future<dynamic> showSessionDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Insert Training Session"),
            content: SingleChildScrollView(
                child: Column(children: [
              TextField(
                controller: txtDescription,
                decoration: InputDecoration(hintText: 'Description'),
              ),
              TextField(
                controller: txtDuration,
                decoration: InputDecoration(hintText: 'Duration'),
              )
            ])),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    txtDescription.text = '';
                    txtDuration.text = '';
                  },
                  child: Text('Cancel')),
              ElevatedButton(onPressed: saveSession, child: Text('Save'))
            ],
          );
        });
  }

  Future saveSession() async {
    DateTime now = DateTime.now();
    String today = '${now.year}-${now.month}-${now.day}';
    Session newSession = new Session(
        helper.getCounter(), today, txtDescription.text, int.tryParse(txtDuration.text) ?? 0);
    helper.writeSession(newSession).then((_) {
      updateScreen();
      helper.updateCounter();
    });
    txtDescription.text = '';
    txtDuration.text = '';
    Navigator.pop(context);
  }

  List<Widget> getContent() {
    List<Widget> tiles = [];
    sessions.forEach((session) {
      tiles.add(Dismissible(
        key: UniqueKey(),
        onDismissed: (_) {
          helper.deleteSession(session.id).then((_) {
            updateScreen();
          });
        },
        child: ListTile(
            title: Text(session.description),
            subtitle: Text('${session.date} - ${session.duration} mins')),
      ));
    });
    return tiles;
  }

  void updateScreen() {
    sessions = helper.getSession();
    setState(() {
    });
  }
}