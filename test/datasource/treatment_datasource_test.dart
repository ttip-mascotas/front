import "package:flutter_test/flutter_test.dart";
import "package:http/http.dart";
import "package:mascotas/datasource/api.dart";
import "package:mascotas/datasource/treatment_datasource.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";

import "mocks.dart";
import "pets_datasource_test.mocks.dart";

@GenerateNiceMocks([MockSpec<Api>()])
void main() {
  late MockApi mockApi;

  setUp(() {
    mockApi = MockApi();
  });

  test("Get a treatment with a given id", () async {
    final TreatmentsDatasource treatmentDatasource =
        TreatmentsDatasource(api: mockApi);

    const treatmentId = 1;

    when(mockApi.get("/treatments/$treatmentId"))
        .thenAnswer((_) async => Response(treatmentWithLogJson, 200));

    final treatment = await treatmentDatasource.getTreatment(treatmentId);

    expect(treatment.id, 1);
    expect(treatment.medicine, "Tramadol");
    expect(treatment.numberOfTime, 10);
    expect(treatment.frequency, 8);
    expect(treatment.dose, "1/4");
    expect(treatment.logs.isNotEmpty, isTrue);
    expect(treatment.startDate, dateTime);
  });

  test("Check treatment log with a given id", () async {
    final TreatmentsDatasource treatmentDatasource =
        TreatmentsDatasource(api: mockApi);

    const treatmentId = 1;
    final treatmentLogId = treatmentLog.id;

    when(mockApi.put(
      "/treatments/$treatmentId/logs/$treatmentLogId",
      body: {"administered": true},
    )).thenAnswer((_) async => Response(treatmentLogJson, 200));

    final treatmentLogResponse = await treatmentDatasource.checkTreatmentLog(
        treatmentId, treatmentLog.id, treatmentLog.administered);

    expect(treatmentLogResponse.administered, isTrue);
  });
}
