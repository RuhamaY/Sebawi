import 'package:Sebawi/application/providers/calendar_provider.dart';
import 'package:Sebawi/application/providers/home_provider.dart';
import 'package:Sebawi/data/models/calendars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
class CalendarItem extends ConsumerWidget {
  final Calendar calendar;

  const CalendarItem({required this.calendar, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey.shade200,
              Colors.grey.shade100,
            ],
          ),
        ),
        child: ListTile(
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${calendar.name[0].toUpperCase()}${calendar.name.substring(1).toLowerCase()}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.green.shade800,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.medical_services,
                        size: 14, color: Colors.green.shade800),
                    const Center(
                      child: Text(
                        " Service Type: ",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(calendar.description),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Scheduled to ${calendar.date}'),
                    ],
                  ),
                ),
              ],
            ),
            leading: Icon(
              Icons.calendar_today,
              size: 40,
              color: Colors.green.shade700,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    ref
                        .read(homeProvider.notifier)
                        .deleteCalendar(calendar.id!);
                    ref.read(calendarsProvider.notifier).refresh();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Calendar Entry Deleted"),
                        duration: Duration(milliseconds: 1000),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      helpText: "Choose new date for volunteering",
                      confirmText: "Update",
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 1),
                    ).then((pickedDate) {
                      if (pickedDate != null) {
                        ref.read(homeProvider.notifier).updateCalendar(
                            pickedDate.toString().split(" ")[0], calendar.id!);
                        ref.read(calendarsProvider.notifier).refresh();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Calendar event updated to",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  pickedDate.toString().split(" ")[0],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            duration: const Duration(milliseconds: 1000),
                          ),
                        );
                      }
                    });
                  },
                ),
              ],
            )),
      ),
    );
  }
}







class CalendarPage extends ConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCalendars = ref.watch(calendarsProvider);
    return asyncCalendars.when(
      data: (calendars) =>
          ListView.builder(
            itemCount: calendars?.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  CalendarItem(
                    calendar: calendars![index],
                  ),
                  Divider(
                    height: 10,
                    thickness: 1,
                    color: Colors.grey.shade200,
                  ),
                ],
              );
            },
          ),
      loading: () =>
      const Center(child: CircularProgressIndicator()),
      error: (err, stack) =>
      const Center(child: Text("Error loading Calendar")),
    );
  }
}
