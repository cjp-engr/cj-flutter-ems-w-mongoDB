part of 'side_navigation_bloc.dart';

class SideNavigationState extends Equatable {
  final int activePage;
  const SideNavigationState({
    required this.activePage,
  });

  factory SideNavigationState.initial() {
    return const SideNavigationState(activePage: 1);
  }

  @override
  List<Object?> get props => [activePage];

  @override
  String toString() => 'SideNavigationState(activePage: $activePage)';

  SideNavigationState copyWith({
    int? activePage,
  }) {
    return SideNavigationState(
      activePage: activePage ?? this.activePage,
    );
  }
}
