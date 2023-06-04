import 'package:axlerate/config/config.dart';
import 'package:axlerate/main.dart';
import 'package:flavor/flavor.dart';
import 'package:flutter/material.dart';

void main() {
  Flavor.create(
    Environment.beta,
    color: Colors.blue,
    name: 'STAGING',
    properties: {
      Keys.apiUrl: 'https://apiv2.axlerate.com',
      Keys.apiKey: Config.siteKey,
    },
  );
  setupApp();
}
