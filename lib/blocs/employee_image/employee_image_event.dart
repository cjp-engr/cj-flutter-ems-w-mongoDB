part of 'employee_image_bloc.dart';

abstract class EmployeeImageEvent extends Equatable {
  const EmployeeImageEvent();

  @override
  List<Object> get props => [];
}

class PickImageEvent extends EmployeeImageEvent {
  final File image;
  final String imageLocalPath;
  const PickImageEvent({
    required this.image,
    required this.imageLocalPath,
  });
}

class SetInitialImageEvent extends EmployeeImageEvent {}
