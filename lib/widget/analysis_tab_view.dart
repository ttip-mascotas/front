import "package:flutter/material.dart";
import "package:flutter_file_downloader/flutter_file_downloader.dart";
import "package:mascotas/model/analysis.dart";
import "package:mascotas/utils/format.dart";
import "package:mascotas/utils/format_url.dart";
import "package:mascotas/widget/pets_divider.dart";

class AnalysisList extends StatelessWidget {
  final List<Analysis> analyses;
  final String messageEmptyList;

  const AnalysisList({
    super.key,
    required this.analyses,
    required this.messageEmptyList,
  });

  @override
  Widget build(BuildContext context) {
    return analyses.isNotEmpty
        ? ListView.separated(
            itemBuilder: (context, index) {
              final analysis = analyses[index];
              return GestureDetector(
                onTap: () => downloadFile(analysis),
                child: Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnalysisDetail(
                          text: analysis.name,
                          icon: Icons.picture_as_pdf_rounded,
                        ),
                        AnalysisDetail(
                          text: formatBytes(analysis.size, 1),
                          icon: Icons.download_for_offline_rounded,
                        ),
                        AnalysisDetail(
                          text: formatDateToString(analysis.createdAt),
                          icon: Icons.calendar_month_rounded,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const PetsDivider(),
            itemCount: analyses.length)
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(messageEmptyList),
          );
  }

  void downloadFile(Analysis analysis) async {
    await FileDownloader.downloadFile(
        url: formatUrl(analysis.url),
        name: analysis.name,
        notificationType: NotificationType.all);
  }
}

class AnalysisDetail extends StatelessWidget {
  final IconData icon;
  final String text;

  const AnalysisDetail({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(icon, color: Colors.purple.shade200),
          ),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
