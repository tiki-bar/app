/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../login_flow/login_flow_service.dart';
import 'support_modal_service.dart';

class SupportModalController {
  final SupportModalService service;

  SupportModalController(this.service);

  void onLogout(BuildContext context) =>
      Provider.of<LoginFlowService>(context, listen: false).setLoggedOut();
}
