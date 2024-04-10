import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:vote_your_face/app.dart';
import 'package:vote_your_face/application/bloc_observer.dart';
import 'package:vote_your_face/injection.dart' as di;
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'amplifyconfiguration.dart';

Future<void> main() {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await _initializeApp();
      runApp(App());
    },
    blocObserver: AppBlocObserver(),
  );
}

Future<void> _initializeApp() async {
  // configure Amplify
  await _configureAmplify();
  await di.init();
}

Future<void> _configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    await Amplify.addPlugins([auth]);
    // note that Amplify cannot be configured more than once!
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    // error handling can be improved for sure!
    // but this will be sufficient for the purposes of this
    safePrint('An error occurred while configuring Amplify: $e');
  }
}
