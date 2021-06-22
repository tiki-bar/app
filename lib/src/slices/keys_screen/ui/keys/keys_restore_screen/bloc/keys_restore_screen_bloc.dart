/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:async';

import 'package:app/src/slices/app/model/app_model_current.dart';
import 'package:app/src/slices/app/model/app_model_user.dart';
import 'package:app/src/slices/app/repository/secure_storage_repository_current.dart';
import 'package:app/src/slices/app/repository/secure_storage_repository_user.dart';
import 'package:app/src/slices/keys_screen/model/keys_screen_model.dart';
import 'package:app/src/slices/keys_screen/secure_storage_repository_keys.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'keys_restore_screen_event.dart';
part 'keys_restore_screen_state.dart';

class KeysRestoreScreenBloc
    extends Bloc<KeysRestoreScreenEvent, KeysRestoreScreenState> {
  final SecureStorageRepositoryKeys _repoLocalSsKeys;
  final SecureStorageRepositoryUser _repoLocalSsUser;
  final SecureStorageRepositoryCurrent _secureStorageRepositoryCurrent;

  KeysRestoreScreenBloc(this._repoLocalSsKeys, this._repoLocalSsUser,
      this._secureStorageRepositoryCurrent)
      : super(KeysRestoreScreenInitial());

  KeysRestoreScreenBloc.provide(BuildContext context)
      : _repoLocalSsKeys =
            RepositoryProvider.of<SecureStorageRepositoryKeys>(context),
        _repoLocalSsUser =
            RepositoryProvider.of<SecureStorageRepositoryUser>(context),
        _secureStorageRepositoryCurrent =
            RepositoryProvider.of<SecureStorageRepositoryCurrent>(context),
        super(KeysRestoreScreenInitial());

  @override
  Stream<KeysRestoreScreenState> mapEventToState(
    KeysRestoreScreenEvent event,
  ) async* {
    if (event is KeysRestoreScreenScanned)
      yield* _mapScannedToState(event);
    else if (event is KeysRestoreScreenKeyUpdated)
      yield* _mapKeyUpdatedToState(event);
    else if (event is KeysRestoreScreenSubmitted)
      yield* _mapSubmittedToState(event);
  }

  Stream<KeysRestoreScreenState> _mapScannedToState(
      KeysRestoreScreenScanned scanned) async* {
    ScanResult result = await BarcodeScanner.scan();
    if (result.type == ResultType.Barcode) {
      String address = _address(result.rawContent);
      String dataKeyPrivate = _dataKey(result.rawContent);
      String signKeyPrivate = _signKey(result.rawContent);
      if (_isValid(address, dataKeyPrivate, signKeyPrivate)) {
        await _saveAndLogIn(address, dataKeyPrivate, signKeyPrivate);
        yield KeysRestoreScreenSuccess(
            null, dataKeyPrivate, null, signKeyPrivate, address);
      }
    }
  }

  Stream<KeysRestoreScreenState> _mapKeyUpdatedToState(
      KeysRestoreScreenKeyUpdated keyUpdated) async* {
    String address = _address(keyUpdated.key);
    String dataKeyPrivate = _dataKey(keyUpdated.key);
    String signKeyPrivate = _signKey(keyUpdated.key);
    yield KeysRestoreScreenInProgress(
        state.dataPublic,
        dataKeyPrivate,
        state.signPublic,
        signKeyPrivate,
        address,
        _isValid(address, dataKeyPrivate, signKeyPrivate));
  }

  Stream<KeysRestoreScreenState> _mapSubmittedToState(
      KeysRestoreScreenSubmitted submitted) async* {
    await _saveAndLogIn(state.address!, state.dataPrivate, state.signPrivate);
    yield KeysRestoreScreenSuccess(
      state.dataPublic,
      state.dataPrivate,
      state.signPublic,
      state.signPrivate,
      state.address,
    );
  }

  /// Verify if credentials are valid
  ///
  /// Checks if any of the keys are null and if they have the correct length.
  bool _isValid(
      String? address, String? dataKeyPrivate, String? signKeyPrivate) {
    var addressValid = address != null && address.length == 64;
    var dataKeyValid = dataKeyPrivate != null && dataKeyPrivate.length == 1624;
    var signKeyValid = signKeyPrivate != null && signKeyPrivate.length == 92;
    return addressValid && dataKeyValid && signKeyValid;
  }

  Future<void> _saveAndLogIn(
      String address, String? dataPrivate, String? signPrivate) async {
    await _repoLocalSsKeys.save(
        address,
        KeysScreenModel(
            address: address,
            dataPrivateKey: dataPrivate,
            dataPublicKey: null,
            signPrivateKey: signPrivate,
            signPublicKey: null));
    AppModelCurrent current = await _secureStorageRepositoryCurrent
        .find(SecureStorageRepositoryCurrent.key);
    await _repoLocalSsUser.save(
        current.email!,
        AppModelUser(
            email: current.email, address: state.address, isLoggedIn: true));
  }

  String _address(String s) {
    List<String> raw = s.split(".");
    return raw[0];
  }

  String _dataKey(String s) {
    List<String> raw = s.split(".");
    return raw[1];
  }

  String _signKey(String s) {
    List<String> raw = s.split(".");
    return raw[2];
  }
}
