import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class CandidateSearch extends StatelessWidget {
  const CandidateSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Autocomplete<UserPaginated>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<UserPaginated>.empty();
        }

        final userRepo = sl<IUserRepository>();
        final Iterable<UserPaginated> users =
            await userRepo.usersFiltered(textEditingValue.text);

        return users;
      },
      optionsViewBuilder: (
        BuildContext context,
        AutocompleteOnSelected<UserPaginated> onSelected,
        Iterable<UserPaginated> options,
      ) {
        if(options.isEmpty) {
          return const SizedBox();
        }

        return ListView.separated(
          shrinkWrap: true,
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
                onTap: () => onSelected(user),
                leading: SizedBox(
                  height: 32,
                  width: 32,
                  child: NetImage(
                    imageSrc: user.profile.imageSrc,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(user.username),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(
            height: 0,
          ),
        );
      },
      onSelected: (UserPaginated selection) => {},
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController controller,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Search candidate',
            ),
            focusNode: focusNode,
            onSubmitted: (String value) => onFieldSubmitted(),
          ),
        );
      },
    );
  }
}
