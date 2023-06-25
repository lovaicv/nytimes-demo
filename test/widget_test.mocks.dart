// Mocks generated by Mockito 5.4.0 from annotations
// in nytimes/test/widget_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;
import 'dart:typed_data' as _i12;
import 'dart:ui' as _i16;

import 'package:connectivity_plus/connectivity_plus.dart' as _i4;
import 'package:geolocator/geolocator.dart' as _i14;
import 'package:get/get.dart' as _i3;
import 'package:get/get_state_manager/src/simple/list_notifier.dart' as _i15;
import 'package:hive/hive.dart' as _i2;
import 'package:hive/src/box/default_compaction_strategy.dart' as _i11;
import 'package:hive/src/box/default_key_comparator.dart' as _i10;
import 'package:mockito/mockito.dart' as _i1;
import 'package:nytimes/api/home_api_provider.dart' as _i5;
import 'package:nytimes/api/home_respository.dart' as _i18;
import 'package:nytimes/controllers/connection_controller.dart' as _i17;
import 'package:nytimes/controllers/location_controller.dart' as _i13;
import 'package:nytimes/models/most_popular_response_model.dart' as _i7;
import 'package:nytimes/models/search_article_response_model.dart' as _i8;
import 'package:nytimes/models/top_stories_response_model.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeBox_0<E> extends _i1.SmartFake implements _i2.Box<E> {
  _FakeBox_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLazyBox_1<E> extends _i1.SmartFake implements _i2.LazyBox<E> {
  _FakeLazyBox_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRxDouble_2 extends _i1.SmartFake implements _i3.RxDouble {
  _FakeRxDouble_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRxBool_3 extends _i1.SmartFake implements _i3.RxBool {
  _FakeRxBool_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeInternalFinalCallback_4<T> extends _i1.SmartFake implements _i3.InternalFinalCallback<T> {
  _FakeInternalFinalCallback_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeConnectivity_5 extends _i1.SmartFake implements _i4.Connectivity {
  _FakeConnectivity_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeHomeProvider_6 extends _i1.SmartFake implements _i5.HomeProvider {
  _FakeHomeProvider_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTopStoriesResponseModel_7 extends _i1.SmartFake implements _i6.TopStoriesResponseModel {
  _FakeTopStoriesResponseModel_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMostPopularResponseModel_8 extends _i1.SmartFake implements _i7.MostPopularResponseModel {
  _FakeMostPopularResponseModel_8(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSearchArticleResponseModel_9 extends _i1.SmartFake implements _i8.SearchArticleResponseModel {
  _FakeSearchArticleResponseModel_9(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [HiveInterface].
///
/// See the documentation for Mockito's code generation for more information.
class MockHiveInterface extends _i1.Mock implements _i2.HiveInterface {
  MockHiveInterface() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void init(
    String? path, {
    _i2.HiveStorageBackendPreference? backendPreference = _i2.HiveStorageBackendPreference.native,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #init,
          [path],
          {#backendPreference: backendPreference},
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i9.Future<_i2.Box<E>> openBox<E>(
    String? name, {
    _i2.HiveCipher? encryptionCipher,
    _i2.KeyComparator? keyComparator = _i10.defaultKeyComparator,
    _i2.CompactionStrategy? compactionStrategy = _i11.defaultCompactionStrategy,
    bool? crashRecovery = true,
    String? path,
    _i12.Uint8List? bytes,
    String? collection,
    List<int>? encryptionKey,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #openBox,
          [name],
          {
            #encryptionCipher: encryptionCipher,
            #keyComparator: keyComparator,
            #compactionStrategy: compactionStrategy,
            #crashRecovery: crashRecovery,
            #path: path,
            #bytes: bytes,
            #collection: collection,
            #encryptionKey: encryptionKey,
          },
        ),
        returnValue: _i9.Future<_i2.Box<E>>.value(_FakeBox_0<E>(
          this,
          Invocation.method(
            #openBox,
            [name],
            {
              #encryptionCipher: encryptionCipher,
              #keyComparator: keyComparator,
              #compactionStrategy: compactionStrategy,
              #crashRecovery: crashRecovery,
              #path: path,
              #bytes: bytes,
              #collection: collection,
              #encryptionKey: encryptionKey,
            },
          ),
        )),
      ) as _i9.Future<_i2.Box<E>>);

  @override
  _i9.Future<_i2.LazyBox<E>> openLazyBox<E>(
    String? name, {
    _i2.HiveCipher? encryptionCipher,
    _i2.KeyComparator? keyComparator = _i10.defaultKeyComparator,
    _i2.CompactionStrategy? compactionStrategy = _i11.defaultCompactionStrategy,
    bool? crashRecovery = true,
    String? path,
    String? collection,
    List<int>? encryptionKey,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #openLazyBox,
          [name],
          {
            #encryptionCipher: encryptionCipher,
            #keyComparator: keyComparator,
            #compactionStrategy: compactionStrategy,
            #crashRecovery: crashRecovery,
            #path: path,
            #collection: collection,
            #encryptionKey: encryptionKey,
          },
        ),
        returnValue: _i9.Future<_i2.LazyBox<E>>.value(_FakeLazyBox_1<E>(
          this,
          Invocation.method(
            #openLazyBox,
            [name],
            {
              #encryptionCipher: encryptionCipher,
              #keyComparator: keyComparator,
              #compactionStrategy: compactionStrategy,
              #crashRecovery: crashRecovery,
              #path: path,
              #collection: collection,
              #encryptionKey: encryptionKey,
            },
          ),
        )),
      ) as _i9.Future<_i2.LazyBox<E>>);

  @override
  _i2.Box<E> box<E>(String? name) => (super.noSuchMethod(
        Invocation.method(
          #box,
          [name],
        ),
        returnValue: _FakeBox_0<E>(
          this,
          Invocation.method(
            #box,
            [name],
          ),
        ),
      ) as _i2.Box<E>);

  @override
  _i2.LazyBox<E> lazyBox<E>(String? name) => (super.noSuchMethod(
        Invocation.method(
          #lazyBox,
          [name],
        ),
        returnValue: _FakeLazyBox_1<E>(
          this,
          Invocation.method(
            #lazyBox,
            [name],
          ),
        ),
      ) as _i2.LazyBox<E>);

  @override
  bool isBoxOpen(String? name) => (super.noSuchMethod(
        Invocation.method(
          #isBoxOpen,
          [name],
        ),
        returnValue: false,
      ) as bool);

  @override
  _i9.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);

  @override
  _i9.Future<void> deleteBoxFromDisk(
    String? name, {
    String? path,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteBoxFromDisk,
          [name],
          {#path: path},
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);

  @override
  _i9.Future<void> deleteFromDisk() => (super.noSuchMethod(
        Invocation.method(
          #deleteFromDisk,
          [],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);

  @override
  List<int> generateSecureKey() => (super.noSuchMethod(
        Invocation.method(
          #generateSecureKey,
          [],
        ),
        returnValue: <int>[],
      ) as List<int>);

  @override
  _i9.Future<bool> boxExists(
    String? name, {
    String? path,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #boxExists,
          [name],
          {#path: path},
        ),
        returnValue: _i9.Future<bool>.value(false),
      ) as _i9.Future<bool>);

  @override
  void resetAdapters() => super.noSuchMethod(
        Invocation.method(
          #resetAdapters,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void registerAdapter<T>(
    _i2.TypeAdapter<T>? adapter, {
    bool? internal = false,
    bool? override = false,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #registerAdapter,
          [adapter],
          {
            #internal: internal,
            #override: override,
          },
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool isAdapterRegistered(int? typeId) => (super.noSuchMethod(
        Invocation.method(
          #isAdapterRegistered,
          [typeId],
        ),
        returnValue: false,
      ) as bool);

  @override
  void ignoreTypeId<T>(int? typeId) => super.noSuchMethod(
        Invocation.method(
          #ignoreTypeId,
          [typeId],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [Box].
///
/// See the documentation for Mockito's code generation for more information.
class MockBox<E> extends _i1.Mock implements _i2.Box<E> {
  MockBox() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Iterable<E> get values => (super.noSuchMethod(
        Invocation.getter(#values),
        returnValue: <E>[],
      ) as Iterable<E>);

  @override
  String get name => (super.noSuchMethod(
        Invocation.getter(#name),
        returnValue: '',
      ) as String);

  @override
  bool get isOpen => (super.noSuchMethod(
        Invocation.getter(#isOpen),
        returnValue: false,
      ) as bool);

  @override
  bool get lazy => (super.noSuchMethod(
        Invocation.getter(#lazy),
        returnValue: false,
      ) as bool);

  @override
  Iterable<dynamic> get keys => (super.noSuchMethod(
        Invocation.getter(#keys),
        returnValue: <dynamic>[],
      ) as Iterable<dynamic>);

  @override
  int get length => (super.noSuchMethod(
        Invocation.getter(#length),
        returnValue: 0,
      ) as int);

  @override
  bool get isEmpty => (super.noSuchMethod(
        Invocation.getter(#isEmpty),
        returnValue: false,
      ) as bool);

  @override
  bool get isNotEmpty => (super.noSuchMethod(
        Invocation.getter(#isNotEmpty),
        returnValue: false,
      ) as bool);

  @override
  Iterable<E> valuesBetween({
    dynamic startKey,
    dynamic endKey,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #valuesBetween,
          [],
          {
            #startKey: startKey,
            #endKey: endKey,
          },
        ),
        returnValue: <E>[],
      ) as Iterable<E>);

  @override
  E? getAt(int? index) => (super.noSuchMethod(Invocation.method(
        #getAt,
        [index],
      )) as E?);

  @override
  Map<dynamic, E> toMap() => (super.noSuchMethod(
        Invocation.method(
          #toMap,
          [],
        ),
        returnValue: <dynamic, E>{},
      ) as Map<dynamic, E>);

  @override
  dynamic keyAt(int? index) => super.noSuchMethod(Invocation.method(
        #keyAt,
        [index],
      ));

  @override
  _i9.Stream<_i2.BoxEvent> watch({dynamic key}) => (super.noSuchMethod(
        Invocation.method(
          #watch,
          [],
          {#key: key},
        ),
        returnValue: _i9.Stream<_i2.BoxEvent>.empty(),
      ) as _i9.Stream<_i2.BoxEvent>);

  @override
  bool containsKey(dynamic key) => (super.noSuchMethod(
        Invocation.method(
          #containsKey,
          [key],
        ),
        returnValue: false,
      ) as bool);

  @override
  _i9.Future<void> put(
    dynamic key,
    E? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [
            key,
            value,
          ],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);

  @override
  _i9.Future<void> putAt(
    int? index,
    E? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #putAt,
          [
            index,
            value,
          ],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);

  @override
  _i9.Future<void> putAll(Map<dynamic, E>? entries) => (super.noSuchMethod(
        Invocation.method(
          #putAll,
          [entries],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);

  @override
  _i9.Future<int> add(E? value) => (super.noSuchMethod(
        Invocation.method(
          #add,
          [value],
        ),
        returnValue: _i9.Future<int>.value(0),
      ) as _i9.Future<int>);

  @override
  _i9.Future<Iterable<int>> addAll(Iterable<E>? values) => (super.noSuchMethod(
        Invocation.method(
          #addAll,
          [values],
        ),
        returnValue: _i9.Future<Iterable<int>>.value(<int>[]),
      ) as _i9.Future<Iterable<int>>);

  @override
  _i9.Future<void> delete(dynamic key) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [key],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);

  @override
  _i9.Future<void> deleteAt(int? index) => (super.noSuchMethod(
        Invocation.method(
          #deleteAt,
          [index],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);

  @override
  _i9.Future<void> deleteAll(Iterable<dynamic>? keys) => (super.noSuchMethod(
        Invocation.method(
          #deleteAll,
          [keys],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);

  @override
  _i9.Future<void> compact() => (super.noSuchMethod(
        Invocation.method(
          #compact,
          [],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);

  @override
  _i9.Future<int> clear() => (super.noSuchMethod(
        Invocation.method(
          #clear,
          [],
        ),
        returnValue: _i9.Future<int>.value(0),
      ) as _i9.Future<int>);

  @override
  _i9.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);

  @override
  _i9.Future<void> deleteFromDisk() => (super.noSuchMethod(
        Invocation.method(
          #deleteFromDisk,
          [],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);

  @override
  _i9.Future<void> flush() => (super.noSuchMethod(
        Invocation.method(
          #flush,
          [],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);
}

/// A class which mocks [LocationController].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocationController extends _i1.Mock implements _i13.LocationController {
  MockLocationController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set streamSubscription(_i9.StreamSubscription<_i14.Position>? _streamSubscription) => super.noSuchMethod(
        Invocation.setter(
          #streamSubscription,
          _streamSubscription,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.RxDouble get longitude => (super.noSuchMethod(
        Invocation.getter(#longitude),
        returnValue: _FakeRxDouble_2(
          this,
          Invocation.getter(#longitude),
        ),
      ) as _i3.RxDouble);

  @override
  set longitude(_i3.RxDouble? _longitude) => super.noSuchMethod(
        Invocation.setter(
          #longitude,
          _longitude,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.RxDouble get latitude => (super.noSuchMethod(
        Invocation.getter(#latitude),
        returnValue: _FakeRxDouble_2(
          this,
          Invocation.getter(#latitude),
        ),
      ) as _i3.RxDouble);

  @override
  set latitude(_i3.RxDouble? _latitude) => super.noSuchMethod(
        Invocation.setter(
          #latitude,
          _latitude,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.RxBool get isGpsEnabled => (super.noSuchMethod(
        Invocation.getter(#isGpsEnabled),
        returnValue: _FakeRxBool_3(
          this,
          Invocation.getter(#isGpsEnabled),
        ),
      ) as _i3.RxBool);

  @override
  set isGpsEnabled(_i3.RxBool? _isGpsEnabled) => super.noSuchMethod(
        Invocation.setter(
          #isGpsEnabled,
          _isGpsEnabled,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.RxBool get isLocationPermitted => (super.noSuchMethod(
        Invocation.getter(#isLocationPermitted),
        returnValue: _FakeRxBool_3(
          this,
          Invocation.getter(#isLocationPermitted),
        ),
      ) as _i3.RxBool);

  @override
  set isLocationPermitted(_i3.RxBool? _isLocationPermitted) => super.noSuchMethod(
        Invocation.setter(
          #isLocationPermitted,
          _isLocationPermitted,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.InternalFinalCallback<void> get onStart => (super.noSuchMethod(
        Invocation.getter(#onStart),
        returnValue: _FakeInternalFinalCallback_4<void>(
          this,
          Invocation.getter(#onStart),
        ),
      ) as _i3.InternalFinalCallback<void>);

  @override
  _i3.InternalFinalCallback<void> get onDelete => (super.noSuchMethod(
        Invocation.getter(#onDelete),
        returnValue: _FakeInternalFinalCallback_4<void>(
          this,
          Invocation.getter(#onDelete),
        ),
      ) as _i3.InternalFinalCallback<void>);

  @override
  bool get initialized => (super.noSuchMethod(
        Invocation.getter(#initialized),
        returnValue: false,
      ) as bool);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  int get listeners => (super.noSuchMethod(
        Invocation.getter(#listeners),
        returnValue: 0,
      ) as int);

  @override
  void onClose() => super.noSuchMethod(
        Invocation.method(
          #onClose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onInit() => super.noSuchMethod(
        Invocation.method(
          #onInit,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void requestLocationService() => super.noSuchMethod(
        Invocation.method(
          #requestLocationService,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void checkLocationService() => super.noSuchMethod(
        Invocation.method(
          #checkLocationService,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void requestLocationPermission() => super.noSuchMethod(
        Invocation.method(
          #requestLocationPermission,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void checkLocationPermission() => super.noSuchMethod(
        Invocation.method(
          #checkLocationPermission,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void update([
    List<Object>? ids,
    bool? condition = true,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #update,
          [
            ids,
            condition,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onReady() => super.noSuchMethod(
        Invocation.method(
          #onReady,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void $configureLifeCycle() => super.noSuchMethod(
        Invocation.method(
          #$configureLifeCycle,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i15.Disposer addListener(_i15.GetStateUpdate? listener) => (super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValue: () {},
      ) as _i15.Disposer);

  @override
  void removeListener(_i16.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void refresh() => super.noSuchMethod(
        Invocation.method(
          #refresh,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void refreshGroup(Object? id) => super.noSuchMethod(
        Invocation.method(
          #refreshGroup,
          [id],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyChildrens() => super.noSuchMethod(
        Invocation.method(
          #notifyChildrens,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListenerId(
    Object? id,
    _i16.VoidCallback? listener,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #removeListenerId,
          [
            id,
            listener,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i15.Disposer addListenerId(
    Object? key,
    _i15.GetStateUpdate? listener,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addListenerId,
          [
            key,
            listener,
          ],
        ),
        returnValue: () {},
      ) as _i15.Disposer);

  @override
  void disposeId(Object? id) => super.noSuchMethod(
        Invocation.method(
          #disposeId,
          [id],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [ConnectionController].
///
/// See the documentation for Mockito's code generation for more information.
class MockConnectionController extends _i1.Mock implements _i17.ConnectionController {
  MockConnectionController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set streamSubscription(_i9.StreamSubscription<_i4.ConnectivityResult>? _streamSubscription) => super.noSuchMethod(
        Invocation.setter(
          #streamSubscription,
          _streamSubscription,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.RxBool get isOffline => (super.noSuchMethod(
        Invocation.getter(#isOffline),
        returnValue: _FakeRxBool_3(
          this,
          Invocation.getter(#isOffline),
        ),
      ) as _i3.RxBool);

  @override
  set isOffline(_i3.RxBool? _isOffline) => super.noSuchMethod(
        Invocation.setter(
          #isOffline,
          _isOffline,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Connectivity get connectivity => (super.noSuchMethod(
        Invocation.getter(#connectivity),
        returnValue: _FakeConnectivity_5(
          this,
          Invocation.getter(#connectivity),
        ),
      ) as _i4.Connectivity);

  @override
  set connectivity(_i4.Connectivity? _connectivity) => super.noSuchMethod(
        Invocation.setter(
          #connectivity,
          _connectivity,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.InternalFinalCallback<void> get onStart => (super.noSuchMethod(
        Invocation.getter(#onStart),
        returnValue: _FakeInternalFinalCallback_4<void>(
          this,
          Invocation.getter(#onStart),
        ),
      ) as _i3.InternalFinalCallback<void>);

  @override
  _i3.InternalFinalCallback<void> get onDelete => (super.noSuchMethod(
        Invocation.getter(#onDelete),
        returnValue: _FakeInternalFinalCallback_4<void>(
          this,
          Invocation.getter(#onDelete),
        ),
      ) as _i3.InternalFinalCallback<void>);

  @override
  bool get initialized => (super.noSuchMethod(
        Invocation.getter(#initialized),
        returnValue: false,
      ) as bool);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  int get listeners => (super.noSuchMethod(
        Invocation.getter(#listeners),
        returnValue: 0,
      ) as int);

  @override
  void onInit() => super.noSuchMethod(
        Invocation.method(
          #onInit,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onClose() => super.noSuchMethod(
        Invocation.method(
          #onClose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i9.Future<bool> getConnection() => (super.noSuchMethod(
        Invocation.method(
          #getConnection,
          [],
        ),
        returnValue: _i9.Future<bool>.value(false),
      ) as _i9.Future<bool>);

  @override
  bool checkConnection(_i4.ConnectivityResult? result) => (super.noSuchMethod(
        Invocation.method(
          #checkConnection,
          [result],
        ),
        returnValue: false,
      ) as bool);

  @override
  void update([
    List<Object>? ids,
    bool? condition = true,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #update,
          [
            ids,
            condition,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onReady() => super.noSuchMethod(
        Invocation.method(
          #onReady,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void $configureLifeCycle() => super.noSuchMethod(
        Invocation.method(
          #$configureLifeCycle,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i15.Disposer addListener(_i15.GetStateUpdate? listener) => (super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValue: () {},
      ) as _i15.Disposer);

  @override
  void removeListener(_i16.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void refresh() => super.noSuchMethod(
        Invocation.method(
          #refresh,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void refreshGroup(Object? id) => super.noSuchMethod(
        Invocation.method(
          #refreshGroup,
          [id],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyChildrens() => super.noSuchMethod(
        Invocation.method(
          #notifyChildrens,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListenerId(
    Object? id,
    _i16.VoidCallback? listener,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #removeListenerId,
          [
            id,
            listener,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i15.Disposer addListenerId(
    Object? key,
    _i15.GetStateUpdate? listener,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addListenerId,
          [
            key,
            listener,
          ],
        ),
        returnValue: () {},
      ) as _i15.Disposer);

  @override
  void disposeId(Object? id) => super.noSuchMethod(
        Invocation.method(
          #disposeId,
          [id],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [HomeRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockHomeRepository extends _i1.Mock implements _i18.HomeRepository {
  MockHomeRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.HomeProvider get provider => (super.noSuchMethod(
        Invocation.getter(#provider),
        returnValue: _FakeHomeProvider_6(
          this,
          Invocation.getter(#provider),
        ),
      ) as _i5.HomeProvider);

  @override
  _i9.Future<_i6.TopStoriesResponseModel> getTopStories() => (super.noSuchMethod(
        Invocation.method(
          #getTopStories,
          [],
        ),
        returnValue: _i9.Future<_i6.TopStoriesResponseModel>.value(_FakeTopStoriesResponseModel_7(
          this,
          Invocation.method(
            #getTopStories,
            [],
          ),
        )),
      ) as _i9.Future<_i6.TopStoriesResponseModel>);

  @override
  _i9.Future<_i7.MostPopularResponseModel> getMostPopular(
    String? path,
    int? period,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMostPopular,
          [
            path,
            period,
          ],
        ),
        returnValue: _i9.Future<_i7.MostPopularResponseModel>.value(_FakeMostPopularResponseModel_8(
          this,
          Invocation.method(
            #getMostPopular,
            [
              path,
              period,
            ],
          ),
        )),
      ) as _i9.Future<_i7.MostPopularResponseModel>);

  @override
  _i9.Future<_i8.SearchArticleResponseModel> searchArticle(
    String? query,
    int? page,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchArticle,
          [
            query,
            page,
          ],
        ),
        returnValue: _i9.Future<_i8.SearchArticleResponseModel>.value(_FakeSearchArticleResponseModel_9(
          this,
          Invocation.method(
            #searchArticle,
            [
              query,
              page,
            ],
          ),
        )),
      ) as _i9.Future<_i8.SearchArticleResponseModel>);
}
