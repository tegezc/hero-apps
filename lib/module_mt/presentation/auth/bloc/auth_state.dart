part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAlreadyLoggedIn extends AuthState {}

class AuthNotLoggedIn extends AuthState {}
