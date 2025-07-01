import 'package:equatable/equatable.dart';
import 'package:movoprive/features/authentication/models/login_response.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponse response;
  final String userId;

  LoginSuccess(this.response, this.userId);

  @override
  List<Object?> get props => [response, userId];
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);

  @override
  List<Object?> get props => [error];
} 