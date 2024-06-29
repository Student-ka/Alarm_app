import 'package:flutter/material.dart';
import 'package:alarm_first/models/alarm.dart';
import 'package:alarm_first/services/notification_service.dart';

class AddAlarmScreen extends StatefulWidget {
  final Function(Alarm) onSave;

  const AddAlarmScreen({super.key, required this.onSave});

  @override
  _AddAlarmScreenState createState() => _AddAlarmScreenState();
}

class _AddAlarmScreenState extends State<AddAlarmScreen> {
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController labelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodaj Alarm'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('Czas Alarmu'),
              trailing: Text(selectedTime.format(context)),
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );
                if (picked != null && picked != selectedTime) {
                  setState(() {
                    selectedTime = picked;
                  });
                }
              },
            ),
            TextField(
              controller: labelController,
              decoration: const InputDecoration(labelText: 'Etykieta'),
            ),
            const Spacer(),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Anuluj'),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    final newAlarm = Alarm(
                      time: selectedTime,
                      label: labelController.text,
                    );
                    widget.onSave(newAlarm);
                    NotificationService().scheduleAlarm(
                      DateTime.now().add(Duration(
                        hours: selectedTime.hour,
                        minutes: selectedTime.minute,
                      )),
                      newAlarm.label,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Zapisz'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
