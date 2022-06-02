import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import '../../blocs/blocs.dart';
import 'package:equatable/equatable.dart';

part 'employee_image_event.dart';
part 'employee_image_state.dart';

class EmployeeImageBloc extends Bloc<EmployeeImageEvent, EmployeeImageState> {
  late StreamSubscription empDetailsSubscription;
  final EmployeeDetailsBloc empDetailsBloc;
  EmployeeImageBloc({
    required this.empDetailsBloc,
  }) : super(EmployeeImageState.initial()) {
    empDetailsSubscription =
        empDetailsBloc.stream.listen((EmployeeDetailsState state) {
      if (state.employeeStatus == EmployeeStatus.clear) {
        add(SetInitialImageEvent());
      }
    });
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

  @override
  Future<void> close() {
    empDetailsSubscription.cancel();
    return super.close();
  }
}
