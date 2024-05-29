import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/circle/cubit/circle_create_form_cubit.dart';
import 'package:vote_your_face/presentation/circle/widgets/create_circle_description_form.dart';
import 'package:vote_your_face/presentation/circle/widgets/create_circle_name_form.dart';

class CreateCircleSheet extends StatelessWidget {
  CreateCircleSheet({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CircleCreateFormCubit(userRepository: sl<IUserRepository>()),
      child: PageView(
        controller: _pageController,
        children: [
          CreateCircleNameForm(
            onNext: _onNext,
          ),
          CreateCircleDescriptionForm(
            onNext: _onNext,
            onPrevious: _onPrevious,
          ),
        ],
      ),
    );
  }

  void _onNext() {
    if (_pageController.hasClients) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPrevious() {
    if (_pageController.hasClients) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
