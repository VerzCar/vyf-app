import 'package:authentication_repository/authentication_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/authentication/bloc/authentication_bloc.dart';
import 'package:vote_your_face/application/circles/bloc/circles_bloc.dart';
import 'package:vote_your_face/application/user/bloc/user_bloc.dart';

final sl = GetIt.I;

Future<void> init() async {
  // state management
  sl.registerFactory(() => AuthenticationBloc(authenticationRepository: sl()));
  sl.registerFactory(() => UserBloc(userRepository: sl()));
  sl.registerFactory(() => CirclesBloc(voteCircleRepository: sl()));

  // repos
  sl.registerSingleton<IAuthenticationRepository>(AuthenticationRepository());
  sl.registerLazySingleton<IUserRepository>(
      () => UserRepository(authenticationRepository: sl()));
  sl.registerLazySingleton<IVoteCircleRepository>(
      () => VoteCircleRepository(authenticationRepository: sl()));
}
