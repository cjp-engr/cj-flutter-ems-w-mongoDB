import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'employee_image_event.dart';
part 'employee_image_state.dart';

class EmployeeImageBloc extends Bloc<EmployeeImageEvent, EmployeeImageState> {
  EmployeeImageBloc() : super(EmployeeImageState.initial()) {
    on<PickImageEvent>(_pickImage);
    on<SetInitialImageEvent>(_setInitialImage);
  }

  void _setInitialImage(
    SetInitialImageEvent event,
    Emitter<EmployeeImageState> emit,
  ) {
    emit(state.copyWith(
      image: null,
      imageLocalPath: '',
    ));
  }

  void _pickImage(
    PickImageEvent event,
    Emitter<EmployeeImageState> emit,
  ) {
    emit(state.copyWith(
      image: event.image,
      imageLocalPath: event.imageLocalPath,
    ));
  }
}
