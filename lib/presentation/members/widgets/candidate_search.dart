import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/members/cubit/candidates_select_cubit.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/theme.dart';

class CandidateSearch extends StatelessWidget {
  const CandidateSearch({super.key});

  @override
  Widget build(BuildContext context) {
    late TextEditingController searchController;
    late FocusNode searchFocusNode;

    return Autocomplete<UserPaginated>(
      displayStringForOption: (user) => user.username,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        try {
          final userRepo = sl<IUserRepository>();
          final Iterable<UserPaginated> users =
              await userRepo.usersFiltered(textEditingValue.text);

          return users.isEmpty ? [UserPaginated.empty] : users;
        } catch (e) {
          print(e);
          return [UserPaginated.empty];
        }
      },
      optionsViewBuilder: (
        BuildContext context,
        AutocompleteOnSelected<UserPaginated> onSelected,
        Iterable<UserPaginated> options,
      ) {
        if (options.isEmpty || options.length == 1 && options.first.id == 0) {
          return const Scaffold(
            body: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No Results'),
                ],
              ),
            ),
          );
        }

        final themeData = Theme.of(context);
        final size = MediaQuery.of(context).size;

        return SizedBox(
          //height: constraints.biggest.height,
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 10),
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              final user = options.elementAt(index);

              return Card(
                key: Key(user.id.toString()),
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                margin: const EdgeInsets.all(0),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  onTap: () => onSelected(user),
                  leading: AvatarImage(
                    src: user.profile.imageSrc,
                    capitalLetters: usersInitials(user.displayName),
                  ),
                  title: Text(user.displayName),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
              height: 3,
              thickness: 3,
              color: themeData.colorScheme.blackColor,
            ),
          ),
        );
      },
      onSelected: (UserPaginated selection) {
        context.read<CandidatesSelectCubit>().addToSelection(user: selection);
        searchController.clear();
        searchFocusNode.unfocus();
      },
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController controller,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) {
        searchController = controller;
        searchFocusNode = focusNode;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Search candidate',
                  ),
                  focusNode: focusNode,
                ),
              ),
              const SizedBox(width: 3),
              focusNode.hasFocus
                  ? TextButton(
                      onPressed: () {
                        searchController.clear();
                        searchFocusNode.unfocus();
                        focusNode.unfocus();
                      },
                      child: const Text('cancel'),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
