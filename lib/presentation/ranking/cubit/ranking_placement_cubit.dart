import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/application/user/user.dart';

part 'ranking_placement_state.dart';

class RankingPlacementCubit extends Cubit<RankingPlacementState> {
  RankingPlacementCubit({
    required IVoteCircleRepository voteCircleRepository,
    required IUserRepository userRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        _userRepository = userRepository,
        super(const RankingPlacementState());

  final IVoteCircleRepository _voteCircleRepository;
  final IUserRepository _userRepository;

  Future<void> loadRankingUser({
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
}
