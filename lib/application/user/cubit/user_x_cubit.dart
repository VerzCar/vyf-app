import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';

part 'user_x_state.dart';

class UserXCubit extends Cubit<UserXState> {
  UserXCubit({
    required IUserRepository userRepository,
  })  :_userRepository = userRepository,
        super(const UserXState());

  final IUserRepository _userRepository;

  Future<void> userXFetched({
    required User currentUser,
    required String identityId,
  }) async {
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
}
