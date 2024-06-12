// Mocks generated by Mockito 5.4.4 from annotations
// in mascotas/test/datasource/pets_datasource_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:convert' as _i6;
import 'dart:io' as _i7;

import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as _i3;
import 'package:http/http.dart' as _i2;
import 'package:http_parser/http_parser.dart' as _i8;
import 'package:mascotas/datasource/api.dart' as _i4;
import 'package:mascotas/notifications/notifier.dart' as _i9;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i10;

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

class _FakeResponse_0 extends _i1.SmartFake implements _i2.Response {
  _FakeResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFlutterLocalNotificationsPlugin_1 extends _i1.SmartFake
    implements _i3.FlutterLocalNotificationsPlugin {
  _FakeFlutterLocalNotificationsPlugin_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [Api].
///
/// See the documentation for Mockito's code generation for more information.
class MockApi extends _i1.Mock implements _i4.Api {
  @override
  _i5.Future<_i2.Response> get(
    String? path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [path],
          {
            #headers: headers,
            #queryParameters: queryParameters,
          },
        ),
        returnValue: _i5.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #get,
            [path],
            {
              #headers: headers,
              #queryParameters: queryParameters,
            },
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #get,
            [path],
            {
              #headers: headers,
              #queryParameters: queryParameters,
            },
          ),
        )),
      ) as _i5.Future<_i2.Response>);

  @override
  _i5.Future<_i2.Response> post(
    String? path, {
    Map<String, String>? headers,
    Object? body,
    _i6.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [path],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i5.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #post,
            [path],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #post,
            [path],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i5.Future<_i2.Response>);

  @override
  _i5.Future<_i2.Response> put(
    String? path, {
    Map<String, String>? headers,
    Object? body,
    _i6.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [path],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i5.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #put,
            [path],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #put,
            [path],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i5.Future<_i2.Response>);

  @override
  _i5.Future<_i2.Response> upload(
    String? path, {
    required _i7.File? file,
    required String? field,
    _i8.MediaType? contentType,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #upload,
          [path],
          {
            #file: file,
            #field: field,
            #contentType: contentType,
          },
        ),
        returnValue: _i5.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #upload,
            [path],
            {
              #file: file,
              #field: field,
              #contentType: contentType,
            },
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #upload,
            [path],
            {
              #file: file,
              #field: field,
              #contentType: contentType,
            },
          ),
        )),
      ) as _i5.Future<_i2.Response>);
}

/// A class which mocks [Notifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotifier extends _i1.Mock implements _i9.Notifier {
  @override
  _i3.FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin =>
      (super.noSuchMethod(
        Invocation.getter(#flutterLocalNotificationsPlugin),
        returnValue: _FakeFlutterLocalNotificationsPlugin_1(
          this,
          Invocation.getter(#flutterLocalNotificationsPlugin),
        ),
        returnValueForMissingStub: _FakeFlutterLocalNotificationsPlugin_1(
          this,
          Invocation.getter(#flutterLocalNotificationsPlugin),
        ),
      ) as _i3.FlutterLocalNotificationsPlugin);

  @override
  set flutterLocalNotificationsPlugin(
          _i3.FlutterLocalNotificationsPlugin?
              _flutterLocalNotificationsPlugin) =>
      super.noSuchMethod(
        Invocation.setter(
          #flutterLocalNotificationsPlugin,
          _flutterLocalNotificationsPlugin,
        ),
        returnValueForMissingStub: null,
      );

  @override
  String get channelId => (super.noSuchMethod(
        Invocation.getter(#channelId),
        returnValue: _i10.dummyValue<String>(
          this,
          Invocation.getter(#channelId),
        ),
        returnValueForMissingStub: _i10.dummyValue<String>(
          this,
          Invocation.getter(#channelId),
        ),
      ) as String);

  @override
  String get channelName => (super.noSuchMethod(
        Invocation.getter(#channelName),
        returnValue: _i10.dummyValue<String>(
          this,
          Invocation.getter(#channelName),
        ),
        returnValueForMissingStub: _i10.dummyValue<String>(
          this,
          Invocation.getter(#channelName),
        ),
      ) as String);

  @override
  _i5.Future<void> requestNotificationsPermission() => (super.noSuchMethod(
        Invocation.method(
          #requestNotificationsPermission,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> scheduleTreatmentNotification({
    required int? id,
    required DateTime? scheduledDate,
    required String? medicine,
    required String? dose,
    required String? petName,
    required int? treatmentId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #scheduleTreatmentNotification,
          [],
          {
            #id: id,
            #scheduledDate: scheduledDate,
            #medicine: medicine,
            #dose: dose,
            #petName: petName,
            #treatmentId: treatmentId,
          },
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> scheduleNotification({
    required int? id,
    required String? title,
    required String? body,
    required DateTime? scheduledDate,
    String? payload,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #scheduleNotification,
          [],
          {
            #id: id,
            #title: title,
            #body: body,
            #scheduledDate: scheduledDate,
            #payload: payload,
          },
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<_i3.NotificationResponse?> notificationResponse() =>
      (super.noSuchMethod(
        Invocation.method(
          #notificationResponse,
          [],
        ),
        returnValue: _i5.Future<_i3.NotificationResponse?>.value(),
        returnValueForMissingStub:
            _i5.Future<_i3.NotificationResponse?>.value(),
      ) as _i5.Future<_i3.NotificationResponse?>);
}
