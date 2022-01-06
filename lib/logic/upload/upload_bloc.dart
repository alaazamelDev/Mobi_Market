import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_management/data/repositories/product_repository.dart';

part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final ProductRepository _productRepository;
  UploadBloc(this._productRepository) : super(UploadInitial()) {
    on<UploadImage>((event, emit) async {
      emit(UploadLoading());
      try {
        final String imageUrl = await _productRepository.uploadImage(
          file: event.file,
          filename: event.filename,
        );
        print('imageUrl is : $imageUrl'); // todo: remove this
        emit(UploadSucceeded(imageUrl)); // image uploaded successfully
      } catch (ex) {
        emit(UploadFailed(ex.toString()));
      }
    });
  }
}
