import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class CirclesSearchBody extends StatelessWidget {
  const CirclesSearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Autocomplete<CirclePaginated>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<CirclePaginated>.empty();
        }

        final vcRepo = sl<IVoteCircleRepository>();
        final Iterable<CirclePaginated> circles =
            await vcRepo.circlesFiltered(name: textEditingValue.text);

        return circles;
      },
      optionsViewBuilder: (
        BuildContext context,
        AutocompleteOnSelected<CirclePaginated> onSelected,
        Iterable<CirclePaginated> options,
      ) {
        return ListView.separated(
          itemCount: options.length,
          itemBuilder: (BuildContext context, int index) {
            final circle = options.elementAt(index);
            return Card(
              key: Key(circle.id.toString()),
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              margin: const EdgeInsets.all(0),
              child: ListTile(
                onTap: () => onSelected(circle),
                leading:       SizedBox(
                  height: 32,
                  width: 32,
                  child: NetImage(
                    imageSrc: circle.imageSrc,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(circle.name),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(height: 0),
        );
      },
      onSelected: (CirclePaginated selection) =>
          context.router.popAndPush(CircleRoute(circleId: selection.id)),
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController controller,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) {
        FocusScope.of(context).requestFocus(focusNode);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Search by circle name',
            ),
            focusNode: focusNode,
            onSubmitted: (String value) => onFieldSubmitted(),
          ),
        );
      },
    );
  }
}
