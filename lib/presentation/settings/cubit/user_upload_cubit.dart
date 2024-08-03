import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/injection.dart';

part 'user_upload_state.dart';

class UserUploadCubit extends Cubit<UserUploadState> {
  UserUploadCubit({
    required IUserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const UserUploadState());

  final IUserRepository _userRepository;

  void onUploadImage({
    required XFile image,
  }) async {
    emit(state.copyWith(
      status: StatusIndicator.loading,
    ));

    try {
      final imageBytes = await image.readAsBytes();
      final imageSrc = await _userRepository.uploadUserProfileImage(
        imageBytes,
      );

      emit(state.copyWith(
        status: StatusIndicator.success,
        uploadedImageSrc: _srcWithAttachedTimestamp(imageSrc),
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

  /// Attach a newly timestamp to image as they are currently always
  /// have the same naming.
  String _srcWithAttachedTimestamp(String src) {
    return '$src?timeStamp=${DateTime.now()}';
  }
}
