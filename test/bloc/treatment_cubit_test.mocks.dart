// Mocks generated by Mockito 5.4.4 from annotations
// in mascotas/test/bloc/treatment_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mascotas/datasource/web_socket_datasource.dart' as _i2;
import 'package:mascotas/model/treatment.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [WebSocketDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockWebSocketDatasource extends _i1.Mock
    implements _i2.WebSocketDatasource {
  @override
  String get baseUrl => (super.noSuchMethod(
        Invocation.getter(#baseUrl),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.getter(#baseUrl),
        ),
        returnValueForMissingStub: _i3.dummyValue<String>(
          this,
          Invocation.getter(#baseUrl),
        ),
      ) as String);

  @override
  _i4.Future<void> connectWebSocket(
    dynamic Function(_i5.Treatment)? onTreatmentReceived,
    int? treatmentId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #connectWebSocket,
          [
            onTreatmentReceived,
            treatmentId,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  void onConnectCallback(
    int? treatmentId,
    dynamic Function(_i5.Treatment)? onTreatmentReceived,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onConnectCallback,
          [
            treatmentId,
            onTreatmentReceived,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Future<void> closeWebSocket() => (super.noSuchMethod(
        Invocation.method(
          #closeWebSocket,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  void checkTreatmentLog(
    int? treatmentId,
    int? treatmentLogId,
    bool? administrated,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #checkTreatmentLog,
          [
            treatmentId,
            treatmentLogId,
            administrated,
          ],
        ),
        returnValueForMissingStub: null,
      );
}
