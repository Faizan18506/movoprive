import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:movoprive/base/constants/app_constants.dart';

class DAuthService {
  static const String baseUrl = 'http://192.168.1.71:5001/api/v1';

  Future<Map<String, dynamic>> startDriverRegistration() async {
    try {
      print('Starting driver registration process...');
      
      final response = await http.post(
        Uri.parse('$baseUrl/auth/driver/startRegistration'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print('Response data: $responseData');
        print('Driver registration started successfully');
        print('Generated userId: ${responseData['data']['userId']}');
        return responseData;
      } else {
        throw jsonDecode(response.body);
      }
    } catch (e) {
      print('Error in startDriverRegistration: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> registerDriver({
    required String userId,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String confirmPassword,
    required String driverType,
    required String rideType,
  }) async {
    try {
      print('Starting driver registration with userId: $userId');
      
      final Map<String, dynamic> requestBody = {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'phone': phone,
        'confirmPassword': confirmPassword,
        'driverType': driverType,
        'rideType': rideType,
      };

      print('Request body: ${jsonEncode(requestBody)}');

      final response = await http.put(
        Uri.parse('$baseUrl/auth/driver/$userId/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print('Driver registration completed successfully');
        return responseData;
      } else {
        throw jsonDecode(response.body);
      }
    } catch (e) {
      print('Error in registerDriver: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> registerCompanyInfo({
    required String userId,
    required String companyInformation,
    required String companyType,
    required String country,
    required String street,
    required int zipCode,
    required String city,
    required int taxIdentificationNumber,
    required int vatId,
    required int businessRegistrationNumber,
  }) async {
    try {
      if (userId.isEmpty) {
        throw Exception('userId cannot be empty');
      }

      print('Starting company information registration for userId: $userId');
      
      final Map<String, dynamic> requestBody = {
        'companyInformation': companyInformation,
        'companyType': companyType,
        'country': country,
        'street': street,
        'zipCode': zipCode,
        'city': city,
        'taxIdentificationNumber': taxIdentificationNumber,
        'vatId': vatId,
        'businessRegistrationNumber': businessRegistrationNumber,
      };

      // Ensure there are no double slashes in the URL
      final url = '$baseUrl/auth/driver/$userId/registerCompanyInfo'.replaceAll(RegExp(r'([^:])//+'), r'$1/');
      print('Making PUT request to: $url');
      print('Request body: ${jsonEncode(requestBody)}');

      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print('Response status: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print('Company information saved successfully');
        return responseData;
      } else {
        print('Error response from server: ${response.body}');
        throw Exception('Failed to register company info: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error in registerCompanyInfo: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> registerIndividualInfo({
    required String userId,
    required File profileImage,
    required Map<String, File> documents,
  }) async {
    try {
      if (userId.isEmpty) {
        throw Exception('userId cannot be empty');
      }

      print('Starting individual information registration for userId: $userId');
      print('Profile image path: ${profileImage.path}');
      print('Documents to upload: ${documents.keys.join(', ')}');

      // Create multipart request
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('$baseUrl/auth/driver/$userId/registerIndividualInfo'),
      );

      // Add profile image
      print('Adding profile image to request...');
      request.files.add(
        await http.MultipartFile.fromPath(
          'profileImage',
          profileImage.path,
        ),
      );

      // Add documents
      print('Adding documents to request...');
      for (var entry in documents.entries) {
        if (entry.value != null) {
          print('Adding document: ${entry.key}');
          request.files.add(
            await http.MultipartFile.fromPath(
              entry.key,
              entry.value!.path,
            ),
          );
        }
      }

      print('Sending multipart request...');
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Response status: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print('Individual information saved successfully');
        return responseData;
      } else {
        print('Error response from server: ${response.body}');
        throw Exception('Failed to register individual info: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error in registerIndividualInfo: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> registerProfileInfo({
    required String userId,
    required File profilePicture,
    required Map<String, File> documents,
  }) async {
    try {
      if (userId.isEmpty) {
        throw Exception('userId cannot be empty');
      }

      print('Starting profile info registration for userId: $userId');
      print('Profile picture path: ${profilePicture.path}');
      print('Documents to upload: ${documents.keys.join(', ')}');

      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('$baseUrl/auth/driver/$userId/registerProfileInfo'),
      );

      // Add profile picture
      request.files.add(
        await http.MultipartFile.fromPath('profilePicture', profilePicture.path),
      );

      // Add documents with correct field names
      for (var entry in documents.entries) {
        if (entry.value != null) {
          print('Adding document: ${entry.key}');
          request.files.add(
            await http.MultipartFile.fromPath(entry.key, entry.value!.path),
          );
        }
      }

      print('Sending multipart request...');
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print('Profile information saved successfully');
        return responseData;
      } else {
        print('Error response from server: ${response.body}');
        throw Exception('Failed to register profile info: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error in registerProfileInfo: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> registerDriverFleetInfo({
    required String userId,
    required bool isWorkerdBefor,
    required bool isElectricVehicles,
    required bool isWomenServing,
    required String totalNumberOfChauffers,
    required String totalFirstClass,
    required String totalBusinessClass,
    required String businessClassVans,
    required String fleetVehiclesDescription,
  }) async {
    try {
      print('Submitting fleet info for userId: $userId');
      final Map<String, dynamic> requestBody = {
        "isWorkerdBefor": isWorkerdBefor.toString(),
        "isElectricVehicles": isElectricVehicles.toString(),
        "isWomenServing": isWomenServing.toString(),
        "totalNumberOfChauffers": totalNumberOfChauffers,
        "totalFirstClass": totalFirstClass,
        "totalBusinessClass": totalBusinessClass,
        "businessClassVans": businessClassVans,
        "fleetVehiclesDescription": fleetVehiclesDescription,
      };
      print('Request body: \\n${jsonEncode(requestBody)}');

      final response = await http.put(
        Uri.parse('$baseUrl/auth/driver/$userId/registerDriverFleetInfo'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        GradientToast.show( "Fleet info saved successfully");
        print('Fleet info saved successfully');

        return responseData;
      } else {
        print('Error response from server: ${response.body}');
        throw Exception('Failed to register fleet info: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error in registerDriverFleetInfo: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> registerVehicleInfo({
    required String userId,
    required Map<String, File> files,
    required Map<String, String> fields,
  }) async {
    try {
      print('Submitting vehicle info for userId: $userId');
      print('Files: ${files.keys}');
      print('Fields: $fields');

      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('$baseUrl/auth/driver/$userId/registerVehicleInfo'),
      );

      // Add files
      for (var entry in files.entries) {
        print('Adding file: ${entry.key} -> ${entry.value.path}');
        request.files.add(await http.MultipartFile.fromPath(entry.key, entry.value.path));
      }

      // Add text fields
      fields.forEach((key, value) {
        print('Adding field: $key -> $value');
        request.fields[key] = value;
      });

      print('Sending multipart request...');
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print('Vehicle information saved successfully');
        return responseData;
      } else {
        print('Error response from server: ${response.body}');
        throw Exception('Failed to register vehicle info: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error in registerVehicleInfo: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> registerDriverPreferredPaymentMethod({
    required String userId,
    required String preferredPaymentMethod,
  }) async {
    try {
      print('Submitting preferred payment method for userId: $userId');
      final Map<String, dynamic> requestBody = {
        "preferredPaymentMethod": preferredPaymentMethod,
      };
      print('Request body: \\n${jsonEncode(requestBody)}');

      final response = await http.put(
        Uri.parse('$baseUrl/auth/driver/$userId/registerDriverPreferredPaymentMethod'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print('Preferred payment method saved successfully');
        return responseData;
      } else {
        print('Error response from server: ${response.body}');
        throw Exception('Failed to register preferred payment method: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error in registerDriverPreferredPaymentMethod: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> submitDriverRegistration({
    required String userId,
  }) async {
    try {
      print('Submitting final registration for userId: $userId');
      final Map<String, dynamic> requestBody = {
        "isSubmitted": "true",
      };
      print('Request body: ${jsonEncode(requestBody)}');

      final response = await http.put(
        Uri.parse('$baseUrl/auth/driver/$userId/submitRegistration'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print('Registration submitted successfully');
        return responseData;
      } else {
        print('Error response from server: ${response.body}');
        throw Exception('Failed to submit registration: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error in submitDriverRegistration: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> driverLogin({
    required String email,
    required String password,
  }) async {
    try {
      print('driverLogin: Starting login process...');
      final Map<String, dynamic> requestBody = {
        "email": email,
        "password": password,
      };
      print('driverLogin: Built request body: ' + jsonEncode(requestBody));

      final url = '$baseUrl/auth/driver/login';
      print('driverLogin: Sending POST request to: ' + url);

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      print('driverLogin: Received response status: \\${response.statusCode}');
      print('driverLogin: Received response body: \\${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print('driverLogin: Login successful, responseData: \\${responseData}');
        return responseData;
      } else {
        print('driverLogin: Error response from server: \\${response.body}');
        throw Exception('Failed to login: \\${response.statusCode} - \\${response.body}');
      }
    } catch (e) {
      print('driverLogin: Exception occurred: $e');
      rethrow;
    }
  }
} 