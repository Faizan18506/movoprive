import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/register_service.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterService _registerService;

  RegisterCubit(this._registerService) : super(RegisterInitial());

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String confirmPassword,
  }) async {
    try {
      print('RegisterCubit - Starting registration process');
      print('RegisterCubit - User details:');
      print('  First Name: $firstName');
      print('  Last Name: $lastName');
      print('  Email: $email');
      print('  Phone: $phone');

      emit(RegisterLoading());
      print('RegisterCubit - Emitted RegisterLoading state');

      final response = await _registerService.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        phone: phone,
        confirmPassword: confirmPassword,
      );

      print('RegisterCubit - Registration successful');
      print('RegisterCubit - Response message: ${response.message}');
      emit(RegisterSuccess(response.message));
    } catch (e) {
      print('RegisterCubit - Registration failed');
      print('RegisterCubit - Error: $e');
      emit(RegisterError(e.toString()));
    }
  }
} 