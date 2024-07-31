part of 'circle_upload_cubit.dart';

final class CircleUploadState extends Equatable {
  const CircleUploadState({
    this.status = StatusIndicator.initial,
    this.uploadedImageSrc = '',
  });

  final StatusIndicator status;
  final String uploadedImageSrc;

  CircleUploadState copyWith({
    StatusIndicator? status,
    String? uploadedImageSrc,
  }) {
    return CircleUploadState(
      status: status ?? this.status,
      uploadedImageSrc: uploadedImageSrc ?? this.uploadedImageSrc,
    );
  }

  @override
  List<Object> get props => [
        status,
      ];
}
