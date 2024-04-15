import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/application/shared/state_status.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({
    required IUserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const UserState()) {
    on<UserInitialLoaded>(_onUserInitialLoaded);
  }

  final IUserRepository _userRepository;

  void _onUserInitialLoaded(
    UserInitialLoaded event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final user = await _userRepository.me();
      print(user);
      emit(state.copyWith(user: user, status: StatusIndicator.success));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }
}
