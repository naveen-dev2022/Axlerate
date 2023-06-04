import 'package:axlerate/values/strings.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Validators {
  String fieldName;
  Validators(this.fieldName);

  List<FieldValidator<dynamic>> validations = [];

  required() {
    validations.add(RequiredValidator(errorText: "$fieldName is required"));
    return this;
  }

  email() {
    validations.add(EmailValidator(errorText: "$fieldName should be a valid email"));
    return this;
  }

  panCard() {
    validations.add(PanValidator(errorText: "$fieldName should be a valid PAN Number"));
    return this;
  }

  range(int minVal, int maxVal) {
    validations
        .add(RangeValidator(min: minVal, max: maxVal, errorText: "$fieldName should be between $minVal and $maxVal"));
    return this;
  }

  min(int length) {
    validations.add(MinLengthValidator(length, errorText: "$fieldName should be atleast $length characters"));
    return this;
  }

  Validators max(int length) {
    validations.add(MaxLengthValidator(length, errorText: "$fieldName should not be greater than $length characters"));
    return this;
  }

  pattern(Pattern pattern, {bool caseSensitive = false}) {
    validations
        .add(PatternValidator(pattern, errorText: 'Doesn\'t match the required pattern', caseSensitive: caseSensitive));
    return this;
  }

  password() {
    validations.add(PatternValidator(Strings.passwordPattern,
        errorText: fieldName + Strings.passwordErrorMessage, caseSensitive: true));
    return this;
  }
}

class PanValidator extends TextFieldValidator {
  /// regex pattern to validate email inputs.
  //final Pattern _panPattern = r"[A-Z]{5}[0-9]{4}[A-Z]{1}";
  final Pattern _panPattern = r"^[A-Za-z]{5}\d{4}[A-Za-z]{1}$";

  PanValidator({required String errorText}) : super(errorText);

  @override
  bool isValid(String? value) => hasMatch(_panPattern.toString(), value!, caseSensitive: false);
}
