/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../slices/api_bouncer/api_bouncer_service.dart';
import '../../slices/login_flow/login_flow_service.dart';
import '../../slices/tiki_http/tiki_http_client.dart';
import 'helper_api_rsp.dart';

class HelperApiAuth {
  final LoginFlowService loginFlowService;
  final ApiBouncerService apiBouncerService;

  HelperApiAuth(this.loginFlowService, this.apiBouncerService);

  Future<HelperApiRsp<T>> proxy<T>(
      Future<HelperApiRsp<T>> Function() request) async {
    HelperApiRsp<T> rsp = await request();
    if (TikiHttpClient.isUnauthorized(rsp.code)) {
      await loginFlowService.refreshAuth();
      rsp = await request();
    }
    return rsp;
  }

  String? get bearer => loginFlowService.model.user?.token?.bearer;
}
