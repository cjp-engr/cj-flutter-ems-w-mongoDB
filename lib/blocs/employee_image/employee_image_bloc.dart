import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'employee_image_event.dart';
part 'employee_image_state.dart';

class EmployeeImageBloc extends Bloc<EmployeeImageEvent, EmployeeImageState> {
  EmployeeImageBloc() : super(EmployeeImageState.initial()) {
    on<PickImageEvent>(_pickImage);
  }

  void _pickImage(
    PickImageEvent event,
    Emitter<EmployeeImageState> emit,
  ) {
    emit(state.copyWith(image: event.image));
  }
}
