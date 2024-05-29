import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/treatment_cubit.dart';
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
    final bool isActivated = dateIsBeforeNow(treatmentLog.datetime);
    final double size = isActivated ? 40 : 20;

    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: isActivated
                      ? () {
                          context
                              .read<TreatmentCubit>()
                              .checkTreatmentLog(treatmentLog.id);
                        }
                      : null,
                  child: Container(
                    height: size,
                    width: size,
                    decoration: BoxDecoration(
                      color: Colors.purple.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: treatmentLog.administered
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          )
                        : null,
                  ),
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

  bool dateIsBeforeNow(DateTime date) {
    DateTime now = DateTime.now();
    return date.isBefore(now);
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          formatDateToShortString(date),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
