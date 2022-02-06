part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class HomeEventFirstFetch extends HomeEvent {}

class HomeEventLoadMore extends HomeEvent {}

class HomeEventFullScreen extends HomeEvent {
  final bool isMain;
  final String path;
  final int seed;
  BuildContext context;
  HomeEventFullScreen(this.seed,
      {required this.context, required this.isMain, required this.path});
}
