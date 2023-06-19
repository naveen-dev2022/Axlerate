class VehicleValidator {
  static bool validateVehicleNumber(String vehicleNumber) {
    if (vehicleNumber.length < 6 || vehicleNumber.length > 10) {
      return false; // Length should be between 6 and 10 characters
    }

    // Extracting components from the vehicle number
    String stateCode = vehicleNumber.substring(0, 2);
    String districtCode = vehicleNumber.substring(2, 4);
    String registrationCode = vehicleNumber.substring(4);

    // Validating state code
    List<String> validStateCodes = [
      'AP',
      'AR',
      'AS',
      'BR',
      'CG',
      'GA',
      'GJ',
      'HR',
      'HP',
      'JH',
      'KA',
      'KL',
      'MP',
      'MH',
      'MN',
      'ML',
      'MZ',
      'NL',
      'OD',
      'PB',
      'RJ',
      'SK',
      'TN',
      'TS',
      'TR',
      'UP',
      'UK',
      'WB'
    ];
    if (!validStateCodes.contains(stateCode.toUpperCase())) {
      return false; // Invalid state code
    }

    // Validating district code
    if (districtCode.contains(RegExp(r'[^a-zA-Z]'))) {
      return false; // District code should consist only of letters
    }

    // Validating registration code
    if (registrationCode.contains(RegExp(r'[^a-zA-Z0-9]'))) {
      return false; // Registration code should consist only of letters and numbers
    }

    // All validation checks passed
    return true;
  }
}
