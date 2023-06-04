class SetOrgPpiPreferenceModel {
  SetOrgPpiPreferenceModel({
    required this.organizationEntityId,
    required this.cardSettings,
    required this.limitConfig,
  });

  final String organizationEntityId;
  final CardSettings cardSettings;
  final LimitConfig limitConfig;

  factory SetOrgPpiPreferenceModel.fromJson(Map<String, dynamic> json) => SetOrgPpiPreferenceModel(
        organizationEntityId: json["organizationId"],
        cardSettings: CardSettings.fromJson(json["cardSettings"]),
        limitConfig: LimitConfig.fromJson(json["limitConfig"]),
      );

  Map<String, dynamic> toJson() => {
        "organizationEntityId": organizationEntityId,
        "cardSettings": cardSettings.toJson(),
        "limitConfig": limitConfig.toJson(),
      };
}

class CardSettings {
  CardSettings({
    required this.atm,
    required this.pos,
    required this.ecom,
    this.international = false,
    this.dcc = false,
    required this.contactless,
  });

  final bool atm;
  final bool pos;
  final bool ecom;
  final bool international;
  final bool dcc;
  final bool contactless;

  factory CardSettings.fromJson(Map<String, dynamic> json) => CardSettings(
        atm: json["atm"],
        pos: json["pos"],
        ecom: json["ecom"],
        international: json["international"],
        dcc: json["dcc"],
        contactless: json["contactless"],
      );

  Map<String, dynamic> toJson() => {
        "atm": atm,
        "pos": pos,
        "ecom": ecom,
        "international": international,
        "dcc": dcc,
        "contactless": contactless,
      };
}

class LimitConfig {
  LimitConfig({
    required this.atm,
    required this.pos,
    required this.ecom,
  });

  final String atm;
  final String pos;
  final String ecom;

  factory LimitConfig.fromJson(Map<String, dynamic> json) => LimitConfig(
        atm: json["ATM"],
        pos: json["POS"],
        ecom: json["ECOM"],
      );

  Map<String, dynamic> toJson() => {
        "ATM": atm,
        "POS": pos,
        "ECOM": ecom,
      };

  LimitConfig copyWith({
    String? atm,
    String? pos,
    String? ecom,
  }) {
    return LimitConfig(
      atm: atm ?? this.atm,
      pos: pos ?? this.pos,
      ecom: ecom ?? this.ecom,
    );
  }

  @override
  String toString() => 'LimitConfig(atm: $atm, pos: $pos, ecom: $ecom)';
}
