import 'package:flutter/material.dart';

class CreateCircleNameForm extends StatelessWidget {
  CreateCircleNameForm({super.key});

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      children: [
        Text(
          'Give the circle a name',
          style: themeData.textTheme.titleMedium,
        ),
        const SizedBox(height: 10.0),
        Text(
          'Circle name',
          style: themeData.textTheme.labelLarge,
        ),
        TextFormField(
          controller: _nameController,
          maxLength: 100,
        ),
        const SizedBox(height: 10.0),
        Text(
          'the circle should have a descriptive naming, to indicate for what the circle stands for. This gives you the ability to give a first hint for what the circle is for.',
          style: themeData.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
