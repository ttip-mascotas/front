import "dart:convert";

import "package:bloc_test/bloc_test.dart";
import "package:flutter_test/flutter_test.dart";
import "package:http/http.dart";
import "package:mascotas/bloc/treatment_websocket_bloc.dart";
import "package:mascotas/bloc/websocket_state.dart";
import "package:mascotas/datasource/treatment_datasource.dart";
import "package:mascotas/datasource/web_socket_datasource.dart";
import "package:mascotas/model/treatment.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";

import "../datasource/mocks.dart";
import "../datasource/pets_datasource_test.mocks.dart";
import "treatment_cubit_test.mocks.dart";

@GenerateNiceMocks([MockSpec<WebSocketDatasource>()])
void main() {
  late MockApi mockApi;
  late MockWebSocketDatasource webSocketDatasource;
  late TreatmentsDatasource treatmentDatasource;
  const int treatmentId = 1;
  const int treatmentLogId = 1;

  setUp(() {
    mockApi = MockApi();
    webSocketDatasource = MockWebSocketDatasource();
    treatmentDatasource = TreatmentsDatasource(api: mockApi);
  });

  blocTest(
    "Al buscar un tratamiento obtengo el tratamiento",
    setUp: () {
      when(
        mockApi.get(
          any,
        ),
      ).thenAnswer((_) async => Response(treatmentJson, 200));
    },
    build: () => WebSocketBloc(
        treatmentsDatasource: treatmentDatasource,
        repository: webSocketDatasource,
        id: treatmentId),
    expect: () => [
      WebSocketTreatmentReceived(Treatment.fromJson(jsonDecode(treatmentJson))),
    ],
  );

  blocTest(
    "Al buscar un tratamiento con un id algo sale mal y obtengo un error",
    setUp: () {
      when(
        mockApi.get(
          any,
        ),
      ).thenAnswer((_) async => throw Exception("Algo salió mal"));
    },
    build: () => WebSocketBloc(
        treatmentsDatasource: treatmentDatasource,
        repository: webSocketDatasource,
        id: 99),
    expect: () => [WebSocketError("Ocurrió un error inesperado")],
  );

  blocTest(
    "Al registrar el avance de un tratamiento obtengo el tratamiento con el check",
    setUp: () {
      when(
        mockApi.get(
          any,
        ),
      ).thenAnswer((_) async => Response(treatmentWithLogJson, 200));
    },
    build: () => WebSocketBloc(
        treatmentsDatasource: treatmentDatasource,
        repository: webSocketDatasource,
        id: treatmentId),
    act: (cubit) => cubit.checkTreatmentLog(treatmentLogId: treatmentLogId),
    expect: () => [
      WebSocketTreatmentReceived(
          Treatment.fromJson(jsonDecode(treatmentWithLogJson))),
    ],
  );

  blocTest(
    "Al registrar el avance de un tratamiento algo sale mal y obtengo un error",
    setUp: () {
      when(mockApi.get("/treatments/1"))
          .thenAnswer((_) async => Response(treatmentWithLogJson, 200));
      when(webSocketDatasource.checkTreatmentLog(
        treatmentId,
        treatmentLogId,
        false,
      )).thenAnswer((_) => throw Exception("Algo salió mal"));
    },
    build: () {
      return WebSocketBloc(
          treatmentsDatasource: treatmentDatasource,
          repository: webSocketDatasource,
          id: treatmentId);
    },
    skip: 1,
    act: (cubit) async {
      await cubit.setupWebSocketListener(treatmentId);
      await cubit.checkTreatmentLog(treatmentLogId: treatmentLogId);
    },
    expect: () => [
      WebSocketError("Ocurrió un error inesperado"),
    ],
  );
}
