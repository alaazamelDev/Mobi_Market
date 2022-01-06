part of 'upload_bloc.dart';

abstract class UploadEvent extends Equatable {
  const UploadEvent();

  @override
  List<Object> get props => [];
}

class UploadImage extends UploadEvent {
  final String filename;
  final File file;

  const UploadImage({
    required this.filename,
    required this.file,
  });

  @override
  List<Object> get props => [filename, file];
}
