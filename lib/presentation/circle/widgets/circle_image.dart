import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/circles/bloc/circles_bloc.dart';
import 'package:vote_your_face/application/rankings/rankings.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/circle/cubit/circle_upload_cubit.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    super.key,
    required this.circle,
  });

  final Circle circle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(30.0),
          ),
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: NetImage(
              imageSrc: circle.imageSrc,
              fit: BoxFit.cover,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(30.0),
          ),
          child: NetImage(
            imageSrc: circle.imageSrc,
            fit: BoxFit.scaleDown,
          ),
        ),
        _editImageAction(context),
      ],
    );
  }

  Widget _editImageAction(BuildContext context) {
    return BlocSelector<UserBloc, UserState, String>(
      selector: (state) => state.user.identityId,
      builder: (context, identityId) =>
          BlocSelector<CircleBloc, CircleState, bool>(
        selector: (state) => CircleSelector.canEdit(state, identityId),
        builder: (context, canEdit) {
          if (canEdit) {
            return Positioned(
              bottom: 0,
              right: 0,
              child: _editImageActionButton(context),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _editImageActionButton(BuildContext context) {
    return BlocProvider(
      create: (context) => CircleUploadCubit(
        voteCircleRepository: sl<IVoteCircleRepository>(),
      ),
      child: BlocListener<CircleUploadCubit, CircleUploadState>(
        listener: (context, state) {
          if (state.status.isLoading) {
            context.router.maybePop();
          }

          if (state.status.isSuccessful) {
            final updatedCircle =
                circle.copyWith(imageSrc: state.uploadedImageSrc);
            context
                .read<CircleBloc>()
                .add(CircleUpdated(circle: updatedCircle));
            context
                .read<CirclesBloc>()
                .add(CirclesUpdated(circle: updatedCircle));
            context
                .read<RankingsCubit>()
                .onViewedRankingsCircleUpdated(updatedCircle);
          }

          if (state.status.isFailure) {
            EventTrigger.error(
              context: context,
              msg: 'Could not upload image. Try again.',
            );
          }
        },
        child: BlocBuilder<CircleUploadCubit, CircleUploadState>(
          builder: (context, state) {
            return IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Colors.white30,
              ),
              onPressed: () {
                final circleUploadCubit = context.read<CircleUploadCubit>();
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context2) {
                    return SingleChildScrollView(
                      child: ImageSelectionSheet(
                        onImageSelected: (image) =>
                            circleUploadCubit.onUploadImage(
                          circleId: circle.id,
                          image: image,
                        ),
                        onImageDeletion: () => circleUploadCubit.onDeleteImage(
                          circleId: circle.id,
                        ),
                      ),
                    );
                  },
                );
              },
              icon: state.status.isLoading
                  ? Container(
                      height: 24,
                      width: 24,
                      padding: const EdgeInsets.all(2.0),
                      child: const CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    )
                  : const Icon(Icons.camera_alt_outlined),
            );
          },
        ),
      ),
    );
  }
}
