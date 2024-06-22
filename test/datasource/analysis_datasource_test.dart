import "package:flutter_test/flutter_test.dart";
import "package:http/http.dart";
import "package:mascotas/datasource/analysis_datasource.dart";
import "package:mascotas/model/analysis.dart";
import "package:mockito/mockito.dart";

import "mocks.dart";
import "pets_datasource_test.mocks.dart";

void main() {

  late MockApi mockApi;

  setUp(() {
    mockApi = MockApi();
  });

  test("Get a analysis with its images", () async {
    final AnalysisDatasource analysisDatasource = AnalysisDatasource(api: mockApi);

    when(mockApi.get("/analyses/1")).thenAnswer((_) async => Response(analysisJson, 200));

    final Analysis analysis = await analysisDatasource.getAnalysis(1);

    expect(analysis.name, "ejemplo.pdf");
    expect(analysis.images.length, 1);
    expect(analysis.images[0].url, "image.jpg");
  });
}