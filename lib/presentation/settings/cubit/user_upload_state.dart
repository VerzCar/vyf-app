part of 'user_upload_cubit.dart';

final class UserUploadState extends Equatable {
  const UserUploadState({
    this.status = StatusIndicator.initial,
    this.uploadedImageSrc = '',
  });

  final StatusIndicator status;
  final String uploadedImageSrc;

  UserUploadState copyWith({
    StatusIndicator? status,
    String? uploadedImageSrc,
  }) {
    return UserUploadState(
      status: status ?? this.status,
      uploadedImageSrc: uploadedImageSrc ?? this.uploadedImageSrc,
    );
  }

  @override
  List<Object> get props => [
        status,
        uploadedImageSrc,
      ];
}
