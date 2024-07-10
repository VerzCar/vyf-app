import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/application/core/core.dart';
import 'package:vote_your_face/application/shared/state_status.dart';
import 'package:vote_your_face/injection.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({
    required IUserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const UserState()) {
    on<UserReset>(_onUserReset);
    on<UserInitialLoaded>(_onUserInitialLoaded);
    on<UserUpdated>(_onUserUpdated);
  }

  final IUserRepository _userRepository;

  void _onUserReset(
    UserReset event,
    Emitter<UserState> emit,
  ) {
    emit(state.reset());
  }

  void _onUserInitialLoaded(
    UserInitialLoaded event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(
      status: StatusIndicator.loading,
    ));

    try {
      final user = await _userRepository.me();
      emit(state.copyWith(
        user: user,
        status: StatusIndicator.success,
      ));
    } catch (e) {
      sl<Logger>().t(
        '_onUserInitialLoaded',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(
        status: StatusIndicator.failure,
      ));
    }
  }

  void _onUserUpdated(
    UserUpdated event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(
      status: StatusIndicator.loading,
    ));

    emit(state.copyWith(
      user: event.user,
      status: StatusIndicator.success,
    ));
  }
}
