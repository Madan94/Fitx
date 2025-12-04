import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';
import '../models/contest.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final String baseUrl = AppConstants.apiBaseUrl;

  Future<Map<String, dynamic>> healthCheck() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      return json.decode(response.body) as Map<String, dynamic>;
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  Future<ContestResponse> getContests() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/contests'));
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return ContestResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load contests: ${response.statusCode}');
      }
    } catch (e) {
      // Return empty contests on error
      return ContestResponse(
        contests: [],
        total: '0',
        message: 'Error loading contests: $e',
      );
    }
  }

  Future<Contest?> getContestById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/contests/$id'));
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return Contest.fromJson(jsonData);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> checkUserJoined(int contestId, String userAddress) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/contests/$contestId/joined/$userAddress'),
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        return {'hasJoined': false, 'error': 'Failed to check join status'};
      }
    } catch (e) {
      return {'hasJoined': false, 'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> preValidateJoin(int contestId, String userAddress) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/contests/$contestId/pre-join'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'userAddress': userAddress}),
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        return {'canJoin': false, 'errors': ['Failed to validate']};
      }
    } catch (e) {
      return {'canJoin': false, 'errors': [e.toString()]};
    }
  }

  Future<Map<String, dynamic>> confirmJoin(int contestId, String userAddress, String txHash) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/contests/$contestId/confirm-join'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userAddress': userAddress,
          'txHash': txHash,
        }),
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        return {'success': false, 'message': 'Failed to confirm join'};
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}

