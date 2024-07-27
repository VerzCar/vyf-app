import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/presentation/circles/cubit/commitment_cubit.dart';

class CommitmentButton extends StatelessWidget {
  const CommitmentButton({
    super.key,
    required this.circleId,
    required this.commitment,
  });

  final int circleId;
  final Commitment commitment;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocBuilder<CommitmentCubit, CommitmentState>(
      builder: (context, state) {
        if (commitment == Commitment.committed &&
                state.status.isCommitmentLoading ||
            commitment == Commitment.rejected &&
                state.status.isRejectionLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              height: 32,
              width: 32,
              child: CircularProgressIndicator(strokeWidth: 3.0),
            ),
          );
        }

        return IconButton(
          onPressed: _onPressed(context, state),
          style: commitment == Commitment.committed
              ? IconButton.styleFrom(
                  foregroundColor: themeData.colorScheme.onPrimary,
                  backgroundColor: themeData.colorScheme.primary)
              : null,
          icon: Icon(
            commitment == Commitment.committed ? Icons.check : Icons.close,
          ),
        );
      },
    );
  }

  VoidCallback? _onPressed(
    BuildContext context,
    CommitmentState state,
  ) {
    if (commitment == Commitment.committed) {
      if (state.status.isRejectionLoading) {
        return null;
      }
      return () =>
          context.read<CommitmentCubit>().committed(circleId: circleId);
    }

    if (state.status.isCommitmentLoading) {
      return null;
    }
    return () => context.read<CommitmentCubit>().rejected(circleId: circleId);
  }
}
