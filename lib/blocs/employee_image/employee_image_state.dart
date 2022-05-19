part of 'employee_image_bloc.dart';

class EmployeeImageState extends Equatable {
  final File? image;
  final String? imageLocalPath;
  const EmployeeImageState({
    required this.image,
    required this.imageLocalPath,
  });

  @override
  List<Object?> get props => [
        image,
        imageLocalPath,
      ];

  factory EmployeeImageState.initial() {
    return const EmployeeImageState(
      image: null,
      imageLocalPath: '',
    );
  }

  @override
  String toString() =>
      'EmployeeImageState(image: $image, imageLocalPath: $imageLocalPath)';

  EmployeeImageState copyWith({
    File? image,
    String? imageLocalPath,
  }) {
    return EmployeeImageState(
      image: image ?? this.image,
      imageLocalPath: imageLocalPath ?? this.imageLocalPath,
    );
  }
}
