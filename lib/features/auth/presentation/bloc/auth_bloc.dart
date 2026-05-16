import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/check_auth_session_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required CheckAuthSessionUseCase checkAuthSession})
      : _checkAuthSession = checkAuthSession,
        super(const AuthStateInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
  }

  final CheckAuthSessionUseCase _checkAuthSession;

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _checkAuthSession(const NoParams());
    result.fold(
      (_) => emit(const Unauthenticated()),
      (session) {
        if (session == null) {
          emit(const Unauthenticated());
        } else {
          emit(Authenticated(session));
        }
      },
    );
  }
}
