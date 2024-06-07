import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/presentation/circle/cubit/circle_edit_form_cubit.dart';

class EditCircleDeleteButton extends StatelessWidget {
  const EditCircleDeleteButton({
    super.key,
    required this.circleId,
  });

  final int circleId;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          foregroundColor: themeData.colorScheme.onError,
          backgroundColor: themeData.colorScheme.error),
      onPressed: () => _showAlertDialog(context, themeData),
      child: const Text('Delete Circle'),
    );
  }

  void _showAlertDialog(
    BuildContext context,
    ThemeData themeData,
  ) async {
    final circleEditFormCubit = BlocProvider.of<CircleEditFormCubit>(context);

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) => BlocProvider.value(
        value: circleEditFormCubit,
        child: AlertDialog(
          title: const Text('Delete Circle?'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'You\'re about to delete this circle. This action is not reversible.'),
                Text('Are you sure you want to delete this circle?'),
              ],
            ),
          ),
          actions: <Widget>[
            OutlinedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: themeData.colorScheme.onError,
                  backgroundColor: themeData.colorScheme.error),
              onPressed: () {
                context.read<CircleEditFormCubit>().onDelete(circleId);
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
