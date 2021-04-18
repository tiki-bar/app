/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/repos/repo_ss_security_keys/repo_ss_security_keys_model.dart';
import 'package:app/src/utilities/utility_functions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RepoSSSecurityKeysBloc {
  static const String _keyPrefix = "com.mytiki.app.";
  final FlutterSecureStorage _secureStorage;
  Map<String, RepoSSSecurityKeysModel> _keyMap = Map();

  RepoSSSecurityKeysBloc(this._secureStorage);

  Future<RepoSSSecurityKeysModel> save(RepoSSSecurityKeysModel keys) async {
    await _secureStorage.write(
        key: _keyPrefix + keys.uuid, value: jsonEncode(keys.toJson()));
    _keyMap[keys.uuid] = await _find(keys.uuid);
    return _keyMap[keys.uuid];
  }

  Future<RepoSSSecurityKeysModel> find(String uuid) async {
    if (!_keyMap.containsKey(uuid)) _keyMap[uuid] = await _find(uuid);
    return _keyMap[uuid];
  }

  Future<RepoSSSecurityKeysModel> _find(String uuid) async {
    Map jsonMap =
        jsonDecodeNullSafe(await _secureStorage.read(key: _keyPrefix + uuid));
    return RepoSSSecurityKeysModel.fromJson(jsonMap);
  }

  bool isValid(RepoSSSecurityKeysModel keys) {
    return (keys != null &&
        keys.uuid != null &&
        keys.address != null &&
        keys.signPrivateKey != null &&
        keys.dataPrivateKey != null);
  }
}
