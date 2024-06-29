import 'package:flutter/material.dart';
import 'package:alarm_first/models/alarm.dart';
import 'package:alarm_first/screens/add_alarm_screen.dart';

class AlarmListScreen extends StatefulWidget {
  const AlarmListScreen({super.key});

  @override
  _AlarmListScreenState createState() => _AlarmListScreenState();
}

class _AlarmListScreenState extends State<AlarmListScreen> {
  List<Alarm> alarms = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarmy'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddAlarmScreen(
                  onSave: (newAlarm) {
                    setState(() {
                      alarms.add(newAlarm);
                    });
                  }
                )),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: alarms.length,
        itemBuilder: (context, index) {
          return AlarmTile(
            alarm: alarms[index],
            onDelete: () {
              setState(() {
                alarms.removeAt(index);
              });
            },
            onToggle: (bool value) {
              setState(() {
                alarms[index].isEnabled = value;
              });
            },
          );
        },
      ),
    );
  }
}

class AlarmTile extends StatelessWidget {
  final Alarm alarm;
  final VoidCallback onDelete;
  final ValueChanged<bool> onToggle;

  const AlarmTile({super.key, required this.alarm, required this.onDelete, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(alarm.time.format(context)),
        subtitle: Text(alarm.label),
        trailing: Switch(
          value: alarm.isEnabled,
          onChanged: onToggle,
        ),
        onLongPress: onDelete,
      ),
    );
  }
}
