import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mascotas/model/dose_control.dart';
import 'package:mascotas/model/schedule_per_day.dart';
import 'package:mascotas/utils/format.dart';

class SchedulePerDayTable extends StatelessWidget {
  final List<SchedulePerDay> dailySchedules;

  const SchedulePerDayTable({super.key, required this.dailySchedules});

  @override
  Widget build(BuildContext context) {
    final int doseControlsRowLength = dailySchedules
        .map((schedulePerDay) => schedulePerDay.doseControls.length)
        .reduce(max);

    final List<TableRow> rows = List.generate(
      dailySchedules.length,
      (index) {
        final dailySchedule = dailySchedules[index];
        final doseControls = dailySchedule.doseControls;

        final dateCell = DateCell(dailySchedule: dailySchedule);

        final doseControlsCells = List.generate(doseControlsRowLength, (index) {
          if (index < doseControls.length) {
            return DoseControlCell(doseControl: doseControls[index]);
          }
          return const TableCell(child: SizedBox());
        });

        return TableRow(children: [dateCell, ...doseControlsCells]);
      },
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Table(
        defaultColumnWidth: const FlexColumnWidth(),
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
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: rows,
      ),
    );
  }
}

class DoseControlCell extends StatelessWidget {
  const DoseControlCell({
    super.key,
    required this.doseControl,
  });

  final DoseControl doseControl;

  @override
  Widget build(BuildContext context) {
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

    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: FittedBox(
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

  int calculateDateDifferenceWithToday(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }
}

class DateCell extends StatelessWidget {
  const DateCell({
    super.key,
    required this.dailySchedule,
  });

  final SchedulePerDay dailySchedule;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: FittedBox(
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
    );
  }
}
