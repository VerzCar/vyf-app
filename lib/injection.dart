import 'package:get_it/get_it.dart';

import 'package:vote_your_face/application/authentication/bloc/authentication_bloc.dart';
// import 'package:user_repository/user_repository.dart';
// import 'package:vote_circle_repository/vote_circle_repository.dart';
// import 'package:vote_your_face/application/authentication/authentication.dart';
// import 'package:authentication_repository/authentication_repository.dart';
// import 'package:vote_your_face/application/user/bloc/user_bloc.dart';
// import 'package:vote_your_face/presentation/camera/bloc/camera_bloc.dart';
// import 'package:vote_your_face/presentation/circle_detail/bloc/circle_detail_bloc.dart';
// import 'package:vote_your_face/presentation/login/login.dart';
// import 'package:vote_your_face/presentation/profile/bloc/profile_bloc.dart';
// import 'package:vote_your_face/presentation/profile/edit/cubit/profile_edit_cubit.dart';
// import 'package:vote_your_face/presentation/sign_up/cubit/sign_up_cubit.dart';
// import 'package:vote_your_face/presentation/verification/cubit/verification_cubit.dart';

final sl = GetIt.I;

Future<void> init() async {
  // state management
  sl.registerFactory(() => AuthenticationBloc(authenticationRepository: sl()));
  // sl.registerFactory(() => UserBloc(userRepository: sl()));
  // sl.registerFactory(() => CircleDetailBloc(voteCircleRepository: sl()));
  // sl.registerFactory(() => LoginBloc(authenticationRepository: sl()));
  // sl.registerFactory(() => SignUpCubit(sl()));
  // sl.registerFactory(() => VerificationCubit(sl()));
  // sl.registerFactory(() => ProfileBloc(userRepository: sl()));
  // sl.registerFactory(() => ProfileEditCubit(sl()));
  // sl.registerFactory(() => CameraBloc());

  // repos
  // sl.registerLazySingleton<AuthenticationRepository>(
  //     () => AuthenticationRepository());
  // sl.registerLazySingleton<UserRepository>(
  //     () => UserRepository(authenticationRepository: sl()));
  // sl.registerLazySingleton<VoteCircleRepository>(
  //     () => VoteCircleRepository(authenticationRepository: sl()));
}
