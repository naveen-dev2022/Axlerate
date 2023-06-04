import 'package:axlerate/config/dev_config.dart';
import 'package:axlerate/main.dart';
import 'package:flavor/flavor.dart';
import 'package:flutter/material.dart';

void main() {
  Flavor.create(
    Environment.dev,
    color: Colors.green,
    name: 'DEV',
    properties: {
      Keys.apiUrl: 'https://dev-api.axlerate.com',
      // Keys.apiUrl: 'https://c255-203-192-195-249.ngrok-free.app',
      Keys.apiKey: DevConfig.siteKey,
    },
  );
  setupApp();
}
