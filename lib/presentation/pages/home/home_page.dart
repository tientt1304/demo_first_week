import 'package:demo_first_week/business_logic/blocs/home/home_bloc.dart';
import 'package:demo_first_week/presentation/widgets/image_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      //khoi tao state ban dau voi count = 0
      create: (_) => HomeBloc(HomeStateInitial()),
      child: WillPopScope(
        onWillPop: () async {
          if (_scrollController.position.pixels <= 10) {
            return true;
          } else {
            _scrollController.animateTo(0,
                duration: const Duration(milliseconds: 1200),
                curve: Curves.fastLinearToSlowEaseIn);
            return false;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              children: [
                BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                  state.imageCount = 10;
                  if (state is HomeStateFetching ||
                      state is HomeStateFinished) {
                    return ImageDisplay(
                        width: _screenWidth - 32,
                        height: _screenHeight * 0.2,
                        path: ApiPath.squareImage(seed: state.mainImageSeed),
                        onTap: () {
                          if (state is HomeStateInitial) {
                            return;
                          }
                          String path = ApiPath.squareImage(
                              seed: state.mainImageSeed,
                              width: ((_screenWidth - 50) * 1.5).toInt());
                          context.read<HomeBloc>().add(HomeEventFullScreen(
                              state.mainImageSeed,
                              context: context,
                              isMain: true,
                              path: path));
                        },
                        seed: state.mainImageSeed);
                  }
                  context.read<HomeBloc>().add(HomeEventFirstFetch());
                  return Image.asset('assets/images/loading.gif', width: _screenWidth - 32,height: _screenHeight * 0.2,);
                }),
                SizedBox(
                  height: _screenHeight * 0.02,
                ),
                Text('Truong Thao Tien'),
                SizedBox(
                  height: _screenHeight * 0.02,
                ),
                BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                  print('state.imageCount: ' + state.imageCount.toString());
                  // return Container();
                  return Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state is HomeStateInitial
                            ? 0
                            : state.imageCount ~/ 2,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  ImageDisplay(
                                      width: (_screenWidth - 40) / 2,
                                      height: _screenHeight * 0.28,
                                      path: ApiPath.squareImage(
                                          seed: state.listImages[index * 2]),
                                      onTap: () {
                                        if (state is HomeStateInitial) {
                                          return;
                                        }
                                        String path = ApiPath.squareImage(
                                            seed: state.listImages[index * 2],
                                            width: ((_screenWidth - 50) * 1.5)
                                                .toInt());
                                        context.read<HomeBloc>().add(
                                            HomeEventFullScreen(
                                                state.listImages[index * 2],
                                                context: context,
                                                isMain: false,
                                                path: path));
                                      },
                                      seed: state.listImages[index * 2]),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ImageDisplay(
                                      width: (_screenWidth - 40) / 2,
                                      height: _screenHeight * 0.28,
                                      path: ApiPath.squareImage(
                                          seed:
                                              state.listImages[index * 2 + 1]),
                                      onTap: () {
                                        if (state is HomeStateInitial) {
                                          return;
                                        }
                                        String path = ApiPath.squareImage(
                                            seed:
                                                state.listImages[index * 2 + 1],
                                            width: ((_screenWidth - 50) * 1.5)
                                                .toInt());
                                        context.read<HomeBloc>().add(
                                            HomeEventFullScreen(
                                                state.listImages[index * 2 + 1],
                                                context: context,
                                                isMain: false,
                                                path: path));
                                      },
                                      seed: state.listImages[index * 2 + 1]),
                                ],
                              ),
                              SizedBox(
                                height: _screenHeight * 0.02,
                              ),
                            ],
                          );
                        }),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ApiPath {
  static const baseURL = 'https://picsum.photos';

  static String squareImage({int width = 350, required int seed}) =>
      '$baseURL/seed/$seed/$width';
}
