
/*

CUBIT ARE RESPONSIBLE FOR STATE MANAGEMENT

*/


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarot_club/features/auth/domain/entities/app_user.dart';
import 'package:tarot_club/features/auth/domain/repos/auth_repo.dart';
import 'package:tarot_club/features/auth/presentation/cubits/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  // get current user
  AppUser? get currentUser => _currentUser;

  // check if user is authenticated
  void checkAuth() async{
    // loading..
    emit(AuthLoading());

    //get current user
    final AppUser? user = await authRepo.getCurrentUser();

    if (user!= null){
      _currentUser = user;
      emit(Authenticated(user));
    } else{
      emit(Unauthenticated());
    }
  }
}