// Mocks generated by Mockito 5.4.4 from annotations
// in mascotas/test/datasource/treatment_datasource_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:convert' as _i6;
import 'dart:io' as _i7;

import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i2;
import 'package:http/http.dart' as _i3;
import 'package:http_parser/http_parser.dart' as _i8;
import 'package:mascotas/datasource/api.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

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

class _FakeFlutterSecureStorage_0 extends _i1.SmartFake
    implements _i2.FlutterSecureStorage {
  _FakeFlutterSecureStorage_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_1 extends _i1.SmartFake implements _i3.Response {
  _FakeResponse_1(
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
  _i2.FlutterSecureStorage get storage => (super.noSuchMethod(
        Invocation.getter(#storage),
        returnValue: _FakeFlutterSecureStorage_0(
          this,
          Invocation.getter(#storage),
        ),
        returnValueForMissingStub: _FakeFlutterSecureStorage_0(
          this,
          Invocation.getter(#storage),
        ),
      ) as _i2.FlutterSecureStorage);

  @override
  _i5.Future<_i3.Response> get(
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
        returnValue: _i5.Future<_i3.Response>.value(_FakeResponse_1(
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
            _i5.Future<_i3.Response>.value(_FakeResponse_1(
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
      ) as _i5.Future<_i3.Response>);

  @override
  _i5.Future<_i3.Response> post(
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
        returnValue: _i5.Future<_i3.Response>.value(_FakeResponse_1(
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
            _i5.Future<_i3.Response>.value(_FakeResponse_1(
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
      ) as _i5.Future<_i3.Response>);

  @override
  _i5.Future<_i3.Response> put(
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
        returnValue: _i5.Future<_i3.Response>.value(_FakeResponse_1(
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
            _i5.Future<_i3.Response>.value(_FakeResponse_1(
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
      ) as _i5.Future<_i3.Response>);

  @override
  _i5.Future<_i3.Response> upload(
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
        returnValue: _i5.Future<_i3.Response>.value(_FakeResponse_1(
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
            _i5.Future<_i3.Response>.value(_FakeResponse_1(
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
      ) as _i5.Future<_i3.Response>);

  @override
  _i5.Future<void> addAuthorizationHeader(Map<String, String>? headers) =>
      (super.noSuchMethod(
        Invocation.method(
          #addAuthorizationHeader,
          [headers],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}