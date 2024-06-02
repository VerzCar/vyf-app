import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circles/circles.dart';
import 'package:vote_your_face/presentation/circle/widgets/create_circle_sheet.dart';
import 'package:vote_your_face/presentation/circles/widgets/widgets.dart';

class YourCircles extends StatelessWidget {
  const YourCircles({super.key});

  final int maxAmountCircles = 3;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    return BlocBuilder<CirclesBloc, CirclesState>(builder: (context, state) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Circles',
                    style: themeData.textTheme.titleLarge,
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      final circlesBloc = BlocProvider.of<CirclesBloc>(context);
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        useSafeArea: true,
                        builder: (BuildContext context2) {
                          return SizedBox(
                            height: size.height * 0.70,
                            child: BlocProvider.value(
                              value: circlesBloc,
                              child: CreateCircleSheet(),
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Create Circle'),
                  ),
                ],
              ),
            ),
            Container(
              height: size.height * 0.25,
              padding: const EdgeInsets.symmetric(vertical: 7.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: state.myCircles.isEmpty
                  ? buildEmptyCirclesPlaceholder(themeData)
                  : buildCirclesPageView(state.myCircles),
            ),
            const SizedBox(height: 3),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${state.myCircles.length}/$maxAmountCircles',
                style: themeData.textTheme.labelSmall,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget buildCirclesPageView(List<Circle> circles) {
    return PageView(
      controller: PageController(viewportFraction: 0.80),
      children: [
        for (final circle in circles)
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: CircleCard(circle: circle),
          ),
      ],
    );
  }

  Widget buildEmptyCirclesPlaceholder(ThemeData themeData) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('It seems like you do not have any circles.'),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: themeData.colorScheme.secondary,
            ),
            onPressed: () {},
            child: const Text('You can create one here'),
          ),
        ],
      ),
    );
  }
}
