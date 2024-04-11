import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:vote_your_face/app.dart';
import 'package:vote_your_face/application/bloc_observer.dart';
import 'package:vote_your_face/injection.dart' as di;
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'amplifyconfiguration.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeApp();
  runApp(App());
}

Future<void> _initializeApp() async {
  await _configureAmplify();
  await di.init();
}

Future<void> _configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    await Amplify.addPlugins([auth]);
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    safePrint('An error occurred while configuring Amplify: $e');
  }
}
