part of 'employee_image_bloc.dart';

abstract class EmployeeImageEvent extends Equatable {
  const EmployeeImageEvent();

  @override
  List<Object> get props => [];
}

class PickImageEvent extends EmployeeImageEvent {
  final File image;
  const PickImageEvent({
    required this.image,
  });
}
