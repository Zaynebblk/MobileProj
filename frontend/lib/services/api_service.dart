import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
class ApiService {
  // For Flutter Web: Use localhost
  // For Android Emulator: Use 10.0.2.2
  // For Physical Device: Use your machine IP (192.168.x.x)
  
  static const String baseUrl = "http://localhost:5000";
  static const String apiPath = ""; // Empty because routes already have /api/auth prefix

  // Login
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      debugPrint('🔄 Logging in: $email');
      
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      ).timeout(const Duration(seconds: 10));

      debugPrint('📨 Response Status: ${response.statusCode}');
      debugPrint('📨 Response Body: ${response.body}');
      debugPrint('📨 Response Headers: ${response.headers}');

      // Check if response body is empty
      if (response.body.isEmpty) {
        return {'error': 'Réponse vide du serveur', 'statusCode': response.statusCode};
      }

      // Try to parse JSON
      try {
        final data = jsonDecode(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          return data;
        } else {
          return {'error': data['message'] ?? 'Erreur serveur', 'statusCode': response.statusCode};
        }
      } catch (e) {
        return {'error': 'Réponse invalide du serveur', 'statusCode': response.statusCode, 'details': response.body};
      }
    } catch (e) {
      debugPrint('❌ Login Error: $e');
      return {'error': 'Erreur de connexion: $e'};
    }
  }

  // Forgot Password
  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      debugPrint('🔄 Forgot password for: $email');
      
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      ).timeout(const Duration(seconds: 10));

      debugPrint('📨 Response Status: ${response.statusCode}');
      debugPrint('📨 Response Body: ${response.body}');
      debugPrint('📨 Response Headers: ${response.headers}');

      // Check if response body is empty
      if (response.body.isEmpty) {
      return {
        "success": false,
        "message": "Réponse vide du serveur",
      };}

      // Try to parse JSON
      try {
        final data = jsonDecode(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
            return {
        "success": true,
        "message": data["message"] ?? "Reset link sent",
      };
        } else {
           return {
      "success": false,
      "message": "User not found",
    };
        }
      } catch (e) {
        return {'error': 'Réponse invalide du serveur', 'statusCode': response.statusCode, 'details': response.body};
      }
    } catch (e) {
      debugPrint('❌ Forgot Password Error: $e');
      return {'error': 'Erreur de connexion: $e'};
    }
  }

  // Verify Reset Code
  static Future<Map<String, dynamic>> verifyResetCode(String email, String code) async {
    try {
      debugPrint('🔄 Verifying reset code for: $email');
      debugPrint('📤 Code: $code (Length: ${code.length})');
      
      final body = jsonEncode({'email': email, 'code': code});
      debugPrint('📤 Request Body: $body');

      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/verify-reset-code'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      ).timeout(const Duration(seconds: 10));

      debugPrint('📨 Response Status: ${response.statusCode}');
      debugPrint('📨 Response Body: ${response.body}');

      // Check if response body is empty
      if (response.body.isEmpty) {
        return {
          "success": false,
          "message": "Réponse vide du serveur",
        };
      }

      // Try to parse JSON
      try {
        final data = jsonDecode(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          return {
            "success": true,
            "message": data["message"] ?? "Code verified successfully",
          };
        } else {
          return {
            "success": false,
            "message": data["message"] ?? "Invalid or expired code",
          };
        }
      } catch (e) {
        return {
          'success': false,
          'error': 'Réponse invalide du serveur',
          'statusCode': response.statusCode,
          'details': response.body
        };
      }
    } catch (e) {
      debugPrint('❌ Verify Reset Code Error: $e');
      return {'success': false, 'error': 'Erreur de connexion: $e'};
    }
  }

}




class Api_Service {
  // Ici tu mets l'URL de ton backend
  static final Dio _dio = Dio(
    BaseOptions(baseUrl: 'http://localhost:5000'), // remplace par ton IP ou localhost
  );

  // POST request
  static Future<Response> post(String path, Map<String, dynamic> data) async {
    return await _dio.post(path, data: data);
  }

  // GET request (optionnel)
  static Future<Response> get(String path) async {
    return await _dio.get(path);
  }
}

