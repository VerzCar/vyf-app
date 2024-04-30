import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/application/user/user.dart';

part 'user_avatar_state.dart';

class UserAvatarCubit extends Cubit<UserAvatarState> {
  UserAvatarCubit({
    required IUserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const UserAvatarState());

  final IUserRepository _userRepository;

  Future<void> getUser({
    required BuildContext context,
    required String identityId,
  }) async {
    final currentUser = context.read<UserBloc>().state.user;

    if (currentUser.identityId == identityId) {
      return emit(
        state.copyWith(
          status: StatusIndicator.success,
          user: currentUser,
        ),
      );
    }

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
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }

  Future<void> initWithExistingUser({
    required User user,
  }) async {
    return emit(
      state.copyWith(
        status: StatusIndicator.success,
        user: user,
      ),
    );
  }
}
