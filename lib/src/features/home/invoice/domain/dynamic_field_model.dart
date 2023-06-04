import 'package:flutter/material.dart';

class AdditionalChargesModel {
  AdditionalChargesModel(this.chargesName, this.chargesValue, this.chargeType);
  TextEditingController chargesName;
  TextEditingController chargesValue;
  IconData chargeType;
}

class AdditionalInfoModel {
  AdditionalInfoModel({required this.fieldName, required this.value});
  TextEditingController fieldName;
  TextEditingController value;
}
