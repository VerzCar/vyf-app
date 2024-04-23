import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/circles/circles.dart';
import 'package:vote_your_face/presentation/circles/widgets/mini_circle_card.dart';

// class CirclesOfInterest extends StatelessWidget {
//   const CirclesOfInterest({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final themeData = Theme.of(context);
//
//     return BlocBuilder<CirclesOfInterestCubit, CirclesOfInterestState>(
//         builder: (context, state) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10.0),
//             margin: const EdgeInsets.symmetric(vertical: 5.0),
//             child: Text(
//               'Circles',
//               style: TextStyle(
//                 fontSize: themeData.textTheme.titleLarge?.fontSize,
//                 fontWeight: themeData.textTheme.titleLarge?.fontWeight,
//               ),
//             ),
//           ),
//           Container(
//             height: size.height * 0.50,
//             padding: const EdgeInsets.symmetric(vertical: 7.0),
//             margin: const EdgeInsets.symmetric(horizontal: 10.0),
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.grey,
//               ),
//               borderRadius: const BorderRadius.all(
//                 Radius.circular(5.0),
//               ),
//             ),
//             child: PageView.builder(
//               controller: PageController(viewportFraction: 0.90),
//               itemCount: (state.circlesOfInterest.length / 3).ceil(),
//               itemBuilder: (context, pageIndex) {
//                 return Column(
//                   children: state.circlesOfInterest
//                       .skip(pageIndex * 3)
//                       .take(3)
//                       .map((circle) => Padding(
//                             padding: const EdgeInsets.only(bottom: 15.0),
//                             child: Container(height: 200, child: MiniCircleCard(circle: circle)),
//                           ))
//                       .toList(),
//                 );
//               },
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }

class CirclesOfInterest extends StatelessWidget {
  const CirclesOfInterest({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    final double containerHeight = size.height * 0.50;

    // Define the fixed height of your items
    final double itemHeight = 200;
    print(containerHeight);
    // Calculate the number of items per page
    final int calculatedItemsPerPage = (containerHeight / itemHeight).floor();
    final int itemsPerPage = calculatedItemsPerPage; //> 3 ? 3 : calculatedItemsPerPage;
    print(itemsPerPage);

    return BlocBuilder<CirclesOfInterestCubit, CirclesOfInterestState>(
        builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              'Circles',
              style: TextStyle(
                fontSize: themeData.textTheme.titleLarge?.fontSize,
                fontWeight: themeData.textTheme.titleLarge?.fontWeight,
              ),
            ),
          ),
          Container(
            height: containerHeight,
            padding: const EdgeInsets.symmetric(vertical: 7.0),
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.90),
              itemCount: (state.circlesOfInterest.length / itemsPerPage).ceil(),
              itemBuilder: (context, pageIndex) {
                return Column(
                  children: state.circlesOfInterest
                      .skip(pageIndex * itemsPerPage)
                      .take(itemsPerPage)
                      .map((circle) => SizedBox(
                    width: itemHeight,
                            height: itemHeight,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: MiniCircleCard(circle: circle),
                            ),
                          ))
                      .toList(),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
