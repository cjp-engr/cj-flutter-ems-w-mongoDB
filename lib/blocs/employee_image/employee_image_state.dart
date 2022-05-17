part of 'employee_image_bloc.dart';

class EmployeeImageState extends Equatable {
  final File? image;
  const EmployeeImageState({
    required this.image,
  });

  @override
  List<Object?> get props => [image];

  factory EmployeeImageState.initial() {
    return const EmployeeImageState(image: null);
  }

  @override
  String toString() => 'EmployeeImageState(image: $image)';

  EmployeeImageState copyWith({
    File? image,
  }) {
    return EmployeeImageState(
      image: image ?? this.image,
    );
  }
}
