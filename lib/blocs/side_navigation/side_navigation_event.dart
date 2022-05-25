part of 'side_navigation_bloc.dart';

abstract class SideNavigationEvent extends Equatable {
  const SideNavigationEvent();

  @override
  List<Object> get props => [];
}

class SwitchActivePageEvent extends SideNavigationEvent {
  final int activePage;
  const SwitchActivePageEvent({
    required this.activePage,
  });
}
