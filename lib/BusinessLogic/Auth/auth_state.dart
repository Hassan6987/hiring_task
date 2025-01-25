part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final User? user;
  final bool isLoading;
  final String? error;
  final bool obscureText;
  final bool checkBox;

  // Constructor
  const AuthState({ this.user, this.isLoading = false, this.error,this.obscureText = true, this.checkBox = false});

  // copyWith function to clone the state and update only provided properties
  AuthState copyWith({bool? obscureText, bool? checkBox, User? user, bool? isLoading, String? error,}) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      obscureText: obscureText ?? this.obscureText,
      checkBox: checkBox ?? this.checkBox,
    );
  }

  @override
  List<Object?> get props => [obscureText, checkBox, user, isLoading, error];
}


