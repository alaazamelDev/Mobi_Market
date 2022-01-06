part of 'upload_bloc.dart';

abstract class UploadState extends Equatable {
  const UploadState();

  @override
  List<Object> get props => [];
}

class UploadInitial extends UploadState {}

class UploadLoading extends UploadState {}

class UploadSucceeded extends UploadState {
  final String imageUrl;

  const UploadSucceeded(this.imageUrl);
}

class UploadFailed extends UploadState {
  final String error;

  const UploadFailed(this.error);
}
