import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/application/user/user.dart';

part 'user_x_state.dart';

class UserXCubit extends Cubit<UserXState> {
  UserXCubit({
    required IUserRepository userRepository,
  })  :_userRepository = userRepository,
        super(const UserXState());

  final IUserRepository _userRepository;

  Future<void> userXFetched({
    required BuildContext context,
    required String identityId,
  }) async {
    print('called fetch');
    print(identityId);
    final currentUser = context.read<UserBloc>().state.user;

    if (currentUser.identityId == identityId) {
      print('take current user');
      return emit(
        state.copyWith(
          status: StatusIndicator.success,
          user: currentUser,
        ),
      );
    }

    emit(state.copyWith(status: StatusIndicator.loading));
    print('load new user');
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
