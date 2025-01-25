import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/User.dart';
import '../../repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  bool obsecure = true;
  bool check = false;

  AuthBloc({required this.authRepository}) : super(const AuthState()) {
    on<ToggleObscure>(_onToggleObsecure);
    on<ToggleCheck>(_onToggleCheck);
    on<LoginRequested>(_onLoginRequested);
  }

  void _onToggleObsecure(ToggleObscure event, Emitter<AuthState> emit) {
    if (obsecure) {
      obsecure = false;
      emit(const AuthState().copyWith(obscureText: false));
    } else {
      obsecure = true;
      emit(const AuthState().copyWith(obscureText: true));
    }
  }
  void _onToggleCheck(ToggleCheck event, Emitter<AuthState> emit) {
    if (check) {
      check = false;
      emit(const AuthState().copyWith(checkBox: false));
    } else {
      check = true;
      emit(const AuthState().copyWith(checkBox: true));
    }
  }
  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final user = await authRepository.login();
      emit(state.copyWith(user: user, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
