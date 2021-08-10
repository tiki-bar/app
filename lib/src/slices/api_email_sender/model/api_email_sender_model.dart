/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_company/model/api_company_model_local.dart';

class ApiEmailSenderModel {
  int? senderId;
  ApiCompanyModelLocal? company;
  String? name;
  String? email;
  String? category;
  String? unsubscribeMailTo;
  DateTime? emailSince;
  bool? unsubscribed;
  DateTime? ignoreUntil;
  int created_epoch;
  int modified_epoch;

  int updated_epoch;

  ApiEmailSenderModel({
    this.senderId,
    this.company,
    this.name,
    this.email,
    this.category,
    this.unsubscribeMailTo,
    this.emailSince,
    DateTime? ignoreUntil,
    int? created_epoch,
    int? modified_epoch,
    this.unsubscribed = false,
  }) : this.ignoreUntil = ignoreUntil ?? DateTime.fromMillisecondsSinceEpoch(0);

  ApiEmailSenderModel.fromMap(map) {
    this.senderId = map['sender_id'];
    this.company = ApiCompanyModelLocal.fromMap(map['company']);
    this.name = map['name'];
    this.email = map['email'];
    this.category = map['category'];
    this.unsubscribeMailTo = map['unsubscribe_mail_to'];
    this.unsubscribed = map['unsubscribed_bool'] == 1 ? true : false;
    if (map['ignore_until_epoch'] != null)
      this.ignoreUntil =
          DateTime.fromMillisecondsSinceEpoch(map['ignore_until_epoch']);
    if (map['email_since_epoch'] != null)
      this.emailSince =
          DateTime.fromMillisecondsSinceEpoch(map['email_since_epoch']);
  }

  Map<String, dynamic> toMap() => {
        'sender_id': senderId,
        'company_id': company?.companyId,
        'name': name,
        'email': email,
        'category': category,
        'unsubscribe_mail_to': unsubscribeMailTo,
        'email_since_epoch': emailSince?.millisecondsSinceEpoch,
        'ignore_until_epoch': ignoreUntil?.millisecondsSinceEpoch,
        'unsubscribed_bool': unsubscribed == true ? 1 : 0,
      };

  @override
  String toString() {
    return 'ApiEmailSenderModel{senderId: $senderId, company: $company, name: $name, email: $email, category: $category, unsubscribeMailTo: $unsubscribeMailTo, emailSince: $emailSince, unsubscribed: $unsubscribed, ignoreUntil: $ignoreUntil}';
  }
}
