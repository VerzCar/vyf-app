import 'package:flutter/material.dart';
import 'package:vote_your_face/presentation/circle/widgets/create_circle_name_form.dart';

class CreateCircleSheet extends StatelessWidget {
  const CreateCircleSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        CreateCircleNameForm(),
        CreateCircleNameForm(),
      ],
    );
  }
}
