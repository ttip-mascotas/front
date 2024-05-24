import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mascotas/model/treatment_log.dart';
import 'package:mascotas/utils/format.dart';

class TreatmentLogsTable extends StatelessWidget {
  final List<TreatmentLog> treatmentLogs;

  const TreatmentLogsTable({super.key, required this.treatmentLogs});

  @override
  Widget build(BuildContext context) {
    final Map<DateTime, List<TreatmentLog>> treatmentLogsGroupedByDate =
        groupBy(treatmentLogs, (TreatmentLog log) {
      return DateTime(log.datetime.year, log.datetime.month, log.datetime.day);
    });

    final int treatmentLogsRowLength = treatmentLogsGroupedByDate.entries
        .map((entry) => entry.value.length)
        .reduce(max);

    final List<TableRow> rows = treatmentLogsGroupedByDate.entries.map((entry) {
      final date = entry.key;
      final treatmentLogs = entry.value;

      final dateCell = DateCell(date: date);

      final treatmentLogCells = List.generate(treatmentLogsRowLength, (index) {
        if (index < treatmentLogs.length) {
          return TreatmentLogCell(treatmentLog: treatmentLogs[index]);
        }
        return const TableCell(child: SizedBox());
      });

      return TableRow(children: [dateCell, ...treatmentLogCells]);
    }).toList();

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

class TreatmentLogCell extends StatelessWidget {
  const TreatmentLogCell({
    super.key,
    required this.treatmentLog,
  });

  final TreatmentLog treatmentLog;

  @override
  Widget build(BuildContext context) {
    IconData? iconData;
    if (treatmentLog.administered) {
      iconData = Icons.check;
    }

    double buttonInsetsAll = 4.0;
    double iconSize = 20;
    if (calculateDateDifferenceWithToday(treatmentLog.datetime) == 0) {
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
                formatTimeToString(treatmentLog.datetime),
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
    required this.date,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            formatDateToShortString(date),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
