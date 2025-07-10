import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qr_meetapp/core/constants/app_strings.dart';
import 'package:qr_meetapp/data/models/appointment_model.dart';
import 'package:qr_meetapp/data/models/user_model.dart';

/// Handles all API communication with the backend
class ApiService {
  final String baseUrl;
  final String apiKey;
  final http.Client client;

  ApiService({
    required this.baseUrl,
    required this.apiKey,
    required this.client,
  });

  /// Common headers for all requests
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };

  /// Handles API response
  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body);

    switch (statusCode) {
      case 200:
      case 201:
        return responseBody;
      case 400:
        throw Exception(responseBody['message'] ?? AppStrings.invalidRequest);
      case 401:
        throw Exception(AppStrings.unauthorized);
      case 403:
        throw Exception(AppStrings.forbidden);
      case 404:
        throw Exception(AppStrings.resourceNotFound);
      case 500:
        throw Exception(AppStrings.serverError);
      default:
        throw Exception(AppStrings.unknownError);
    }
  }

  /// User authentication
  Future<UserModel> authenticate(String email, String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: _headers,
      body: json.encode({'email': email, 'password': password}),
    );

    final data = _handleResponse(response);
    return UserModel.fromJson(data['user']);
  }

  /// User registration
  Future<UserModel> register(UserModel user, String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: _headers,
      body: json.encode({
        'user': user.toJson(),
        'password': password,
      }),
    );

    final data = _handleResponse(response);
    return UserModel.fromJson(data['user']);
  }

  /// Fetch user appointments
  Future<List<AppointmentModel>> getAppointments(String userId) async {
    final response = await client.get(
      Uri.parse('$baseUrl/users/$userId/appointments'),
      headers: _headers,
    );

    final data = _handleResponse(response);
    return (data['appointments'] as List)
        .map((json) => AppointmentModel.fromJson(json))
        .toList();
  }

  /// Create new appointment
  Future<AppointmentModel> createAppointment(AppointmentModel appointment) async {
    final response = await client.post(
      Uri.parse('$baseUrl/appointments'),
      headers: _headers,
      body: json.encode(appointment.toJson()),
    );

    final data = _handleResponse(response);
    return Appointment.fromJson(data['appointment']);
  }

  /// Update existing appointment
  Future<Appointment> updateAppointment(Appointment appointment) async {
    final response = await client.put(
      Uri.parse('$baseUrl/appointments/${appointment.id}'),
      headers: _headers,
      body: json.encode(appointment.toJson()),
    );

    final data = _handleResponse(response);
    return Appointment.fromJson(data['appointment']);
  }

  /// Cancel appointment
  Future<void> cancelAppointment(String appointmentId) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/appointments/$appointmentId'),
      headers: _headers,
    );

    _handleResponse(response);
  }
}