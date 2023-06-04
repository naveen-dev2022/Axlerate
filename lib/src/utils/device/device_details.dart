import 'package:axlerate/main.dart';
import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:safe_device/safe_device.dart';

class UserDevice {
  static Future<bool> detectSafeDevice() async {
    bool toRet = true;

    bool isJailBroken = false;
    bool isRealDevice = true;
    bool isSafeDevice = true;

    if (!kIsWeb) {
      try {
        isJailBroken = await SafeDevice.isJailBroken;
        isRealDevice = await SafeDevice.isRealDevice;
        // isSafeDevice = await SafeDevice.isSafeDevice;
      } catch (error) {
        debugPrint(error.toString());
      }

      try {
        LocalAuthentication auth = LocalAuthentication();
        final List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

        if (availableBiometrics.isNotEmpty) {
          isSafeDevice = true;
        } else {
          bool isDeviceSupporeted = await auth.isDeviceSupported();
          if (isDeviceSupporeted) {
            isSafeDevice = true;
          } else {
            isSafeDevice = false;
          }
        }
      } catch (error) {
        debugPrint("Exception while getting Availabe Biometrics");
      }

      debugPrint("Jail Broken :: $isJailBroken - Real Device :: $isRealDevice - Safe Device :: $isSafeDevice");

      if (isJailBroken) {
        toRet = false;
        await sharedPreferences.setString("errorMessage", "This Device appears to be JailBroken.");
      }

      if (!isRealDevice) {
        toRet = false;
        await sharedPreferences.setString("errorMessage", "This Device dosent seems to be Real.");
      }

      if (!isSafeDevice) {
        toRet = false;
        await sharedPreferences.setString("errorMessage", "Enable Password or Pin in you device.");
      }
    }

    return toRet;
  }
}
