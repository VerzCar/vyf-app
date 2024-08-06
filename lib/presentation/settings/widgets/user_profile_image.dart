import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/application/user/bloc/user_bloc.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/settings/cubit/user_upload_cubit.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        UserXProvider(
          identityId: user.identityId,
          child: UserAvatar(
            key: ValueKey(user.identityId),
            option: const UserAvatarOption(
              size: AvatarSize.full,
            ),
          ),
        ),
        _editImageAction(context),
      ],
    );
  }

  Widget _editImageAction(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: _editImageActionButton(context),
    );
  }

  Widget _editImageActionButton(BuildContext context) {
    return BlocProvider(
      create: (context) => UserUploadCubit(
        userRepository: sl<IUserRepository>(),
      ),
      child: BlocListener<UserUploadCubit, UserUploadState>(
        listener: (context, state) {
          if (state.status.isLoading) {
            context.router.maybePop();
          }

          if (state.status.isSuccessful) {
            final currentUser = context.read<UserBloc>().state.user;
            final updatedProfile =
                currentUser.profile.copyWith(imageSrc: state.uploadedImageSrc);
            final updatedUser = currentUser.copyWith(profile: updatedProfile);
            context.read<UserBloc>().add(UserUpdated(user: updatedUser));
          }

          if (state.status.isFailure) {
            EventTrigger.error(
              context: context,
              msg: 'Could not upload image. Try again.',
            );
          }
        },
        child: BlocBuilder<UserUploadCubit, UserUploadState>(
          builder: (context, state) {
            return IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Colors.white30,
              ),
              onPressed: () {
                final circleUploadCubit = context.read<UserUploadCubit>();
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context2) {
                    return SingleChildScrollView(
                      child: ImageSelectionSheet(
                        onImageSelected: (image) =>
                            circleUploadCubit.onUploadImage(
                          image: image,
                        ),
                        onImageDeletion: () =>
                            circleUploadCubit.onDeleteImage(),
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
