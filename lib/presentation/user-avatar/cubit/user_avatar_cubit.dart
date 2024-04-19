import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';

part 'user_avatar_state.dart';

class UserAvatarCubit extends Cubit<UserAvatarState> {
  UserAvatarCubit({
    required IUserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const UserAvatarState());

  final IUserRepository _userRepository;

  Future<void> getUser(String identityId) async {
    if (state.user.identityId == identityId) return;

    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final user = await _userRepository.x(identityId);
      emit(
        state.copyWith(
          status: StatusIndicator.success,
          user: user,
        ),
      );
    } catch (e) {
      print(e);
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }
}
