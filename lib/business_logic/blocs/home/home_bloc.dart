import 'dart:math';

import 'package:demo_first_week/presentation/pages/home/image_full_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late HomeState _currentState;

  HomeBloc(HomeState init) : super(init) {
    _currentState = init;
    on<HomeEventFirstFetch>(_onHomeEventFirstFetch);
    on<HomeEventLoadMore>(_onHomeEventLoadMore);
    on<HomeEventFullScreen>(_onHomeEventFullScreen);
  }

  void _onHomeEventFirstFetch(
      HomeEventFirstFetch event, Emitter<HomeState> emit) async {
    var seed = Random().nextInt(10000);
    var state = HomeStateFinished();
    state.imageCount = 10;
    state.mainImageSeed = seed;
    for (var index = 0; index < state.imageCount; index++) {
      seed = Random().nextInt(10000);
      state.listImages.add(seed);
    }
    await Future.delayed(const Duration(seconds: 1));
    _currentState = state;
    emit(state);
    return null;
  }

  void _onHomeEventLoadMore(HomeEventLoadMore event, Emitter<HomeState> emit) async{
    var fetchingState = HomeStateFetching();
    fetchingState.mainImageSeed = _currentState.mainImageSeed;
    fetchingState.imageCount = _currentState.imageCount;
    fetchingState.listImages = _currentState.listImages;
    emit(fetchingState);
    await Future.delayed(const Duration(microseconds: 750));
    var state = HomeStateFinished();
    state.mainImageSeed = _currentState.mainImageSeed;
    state.imageCount = _currentState.imageCount + 10;
    state.listImages = _currentState.listImages;
    for (var i = 0; i < 10; i++) {
      int seed = Random().nextInt(100000);
      state.listImages.add(seed);
    }
    _currentState = state;
    emit(state);
    return null;
  }

  void _onHomeEventFullScreen(
      HomeEventFullScreen event, Emitter<HomeState> emit) async {
    Navigator.push(
        event.context,
        MaterialPageRoute(
            builder: (context) => ImageFullScreen(
                  path: event.path,
                  tag: '${event.seed}',
                )));
    return null;
  }
}
