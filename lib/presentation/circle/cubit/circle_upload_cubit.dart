import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/injection.dart';

part 'circle_upload_state.dart';

class CircleUploadCubit extends Cubit<CircleUploadState> {
  CircleUploadCubit({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const CircleUploadState());

  final IVoteCircleRepository _voteCircleRepository;

  void onUploadImage({
    required int circleId,
    required XFile image,
  }) async {
    emit(state.copyWith(
      status: StatusIndicator.loading,
    ));

    try {
      final imageBytes = await image.readAsBytes();
      final imageSrc =
          await _voteCircleRepository.uploadCircleImage(circleId, imageBytes);

      emit(state.copyWith(
        status: StatusIndicator.success,
        uploadedImageSrc: imageSrc,
      ));
    } catch (e) {
      sl<Logger>().t(
        'onUploadImage',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(
        status: StatusIndicator.failure,
      ));
    }
  }
}
