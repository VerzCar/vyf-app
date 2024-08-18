import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/injection.dart';

part 'user_x_state.dart';

class UserXCubit extends Cubit<UserXState> {
  UserXCubit({
    required IUserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const UserXState());

  final IUserRepository _userRepository;

  void userXFetched({
    required User currentUser,
    required String identityId,
  }) async {
    if (currentUser.identityId == identityId) {
      emit(
        state.copyWith(
          status: StatusIndicator.success,
          user: currentUser,
        ),
      );
      return;
    }

    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final user = await _userRepository.x(identityId);

      // TODO; this is currently a bug when switching from ranking to ranking therefore check if the state exists before emitting something
      if (isClosed) return;

      emit(
        state.copyWith(
          status: StatusIndicator.success,
          user: user,
        ),
      );
    } catch (e) {
      sl<Logger>().t(
        'userXFetched',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }

  void currentUserChanged({
    required User currentUser,
    required String identityId,
  }) {
    if (currentUser.identityId == identityId) {
      emit(
        state.copyWith(
          status: StatusIndicator.success,
          user: currentUser,
        ),
      );
      return;
    }
  }
}
