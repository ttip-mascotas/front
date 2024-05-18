import 'package:flutter/material.dart';
import 'package:mascotas/model/schedule_per_day.dart';
import 'package:mascotas/utils/format.dart';

class SchedulePerDayTable extends StatelessWidget {
  final List<SchedulePerDay> dailySchedules;

  const SchedulePerDayTable({super.key, required this.dailySchedules});

  int calculateDateDifferenceWithToday(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  @override
  Widget build(BuildContext context) {
    var rows = <TableRow>[];
    for (var dailySchedule in dailySchedules) {
      var cells = <TableCell>[
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              formatDateToShortString(dailySchedule.date),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ];

      for (var doseControl in dailySchedule.doseControls) {
        IconData? iconData;
        if (doseControl.supplied) {
          iconData = Icons.check;
        }

        double buttonInsetsAll = 4.0;
        double iconSize = 20;
        if (calculateDateDifferenceWithToday(doseControl.time) == 0) {
          buttonInsetsAll = 8.0;
          iconSize = 40;
        }

        cells.add(
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: EdgeInsets.all(buttonInsetsAll),
                    ),
                    onPressed: () {},
                    child: Icon(
                      iconData,
                      color: Colors.white,
                      size: iconSize,
                    ),
                  ),
                  Text(
                    formatTimeToString(doseControl.time),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      rows.add(TableRow(children: cells));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Table(
            border: const TableBorder(
              horizontalInside: BorderSide(
                width: 1,
                color: Colors.purple,
                style: BorderStyle.solid,
              ),
              verticalInside: BorderSide(
                width: 1,
                color: Colors.purple,
                style: BorderStyle.solid,
              ),
            ),
            columnWidths: const <int, TableColumnWidth>{
              0: IntrinsicColumnWidth(),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: rows,
          ),
        ),
      ),
    );
  }
}
