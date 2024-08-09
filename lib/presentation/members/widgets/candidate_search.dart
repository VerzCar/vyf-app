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

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.64,
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
                            capitalLetters: usersInitials(user.username),
                          ),
                          title: Text(user.username),
                          trailing: Checkbox(
                            value: false,
                            onChanged: (value) => onSelected(user),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      height: 3,
                      thickness: 3,
                      color: themeData.colorScheme.blackColor,
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => {},
                          style: ElevatedButton.styleFrom(
                              foregroundColor: themeData.colorScheme.onPrimary,
                              backgroundColor: themeData.colorScheme.primary),
                          child: const Text('Add'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      onSelected: (UserPaginated selection) =>
          context.read<CandidatesSelectCubit>().addToSelection(user: selection),
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController controller,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) {
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
              TextButton(
                onPressed: () {
                  controller.clear();
                  focusNode.unfocus();
                },
                child: const Text('cancel'),
              ),
            ],
          ),
        );
      },
    );
  }
}
