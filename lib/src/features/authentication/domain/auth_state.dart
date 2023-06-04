import 'package:axlerate/src/features/authentication/domain/auth_result.dart';
import 'package:axlerate/src/features/authentication/domain/user_model.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class AuthState {
  final AuthResult? result;
  final bool isLoading;
  final UserModel? userModel;
  final String? token;

  const AuthState({
    required this.result,
    required this.isLoading,
    this.userModel,
    this.token,
  });

  const AuthState.unknown()
      : result = null,
        isLoading = false,
        userModel = null,
        token = null;

  const AuthState.pending(UserModel? user, String? loginToken)
      : result = AuthResult.pending,
        isLoading = false,
        userModel = user,
        token = loginToken;

  const AuthState.success(UserModel model)
      : result = AuthResult.success,
        isLoading = false,
        userModel = model,
        token = null;

  AuthState copiedWith(bool isLoading, [UserModel? user]) => AuthState(
        result: result,
        isLoading: isLoading,
        userModel: user,
      );

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) || (result == other.result && isLoading == other.isLoading);

  @override
  int get hashCode => Object.hash(
        result,
        isLoading,
      );
}
