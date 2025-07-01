import 'package:equatable/equatable.dart';
import 'package:movoprive/features/authentication/models/otp_response.dart';

abstract class OtpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {
  final OtpResponse response;
  final String token;

  OtpSuccess(this.response, this.token);

  @override
  List<Object?> get props => [response, token];
}

class OtpFailure extends OtpState {
  final String error;

  OtpFailure(this.error);

  @override
  List<Object?> get props => [error];
} 