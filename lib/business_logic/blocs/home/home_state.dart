part of 'home_bloc.dart';

class HomeState {
  late int mainImageSeed;
  late int imageCount;
  List<int> listImages = [];

  HomeState();
}

class HomeStateInitial extends HomeState {
  HomeStateInitial();
}

class HomeStateFetching extends HomeState {
  HomeStateFetching();
}

class HomeStateFinished extends HomeState {
  HomeStateFinished();
}
