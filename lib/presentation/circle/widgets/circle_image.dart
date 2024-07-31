import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/presentation/shared/widgets/image/image_selection_sheet.dart';

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
        NetImage(
          imageSrc: circle.imageSrc,
          fit: BoxFit.scaleDown,
        ),
        _editImageActionButton(context),
      ],
    );
  }

  Widget _editImageActionButton(BuildContext context) {
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
              child: IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white30,
                ),
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context2) {
                    return SingleChildScrollView(
                      child: ImageSelectionSheet(
                        onImageSelected: (s) => print(s),
                      ),
                    );
                  },
                ),
                icon: const Icon(Icons.edit_outlined),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
