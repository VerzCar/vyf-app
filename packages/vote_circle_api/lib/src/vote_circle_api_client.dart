import 'dart:convert';
import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:logger/logger.dart';
import 'package:vote_circle_api/vote_circle_api.dart';
import 'package:http/http.dart' as http;
import 'i_vote_circle_api_client.dart';

part 'api-errors.dart';

class VoteCircleApiClient implements IVoteCircleApiClient {
  VoteCircleApiClient({required authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  final IAuthenticationRepository _authenticationRepository;
  final String _baseApiHost = 'vyf-vote-circle-309d72dfd728.herokuapp.com';
  final String _basePath = 'v1/api/vote-circle';

  @override
  Future<Circle> fetchCircle(String id) async {
    var logger = Logger();

    try {
      final res = await http.get(_uri(path: 'circle/$id'), headers: _headers());

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('querying circle server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>);

      if (res.statusCode == HttpStatus.ok) {
        return Circle.fromJson(apiResponse.data);
      }

      logger.e('querying circle failed: $apiResponse');
      throw QueryCircleFailure(
        statusCode: res.statusCode,
        msg: apiResponse.msg,
        status: apiResponse.status,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Circle>> fetchCircles() async {
    var logger = Logger();

    try {
      final res = await http.get(_uri(path: 'circles'), headers: _headers());

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('querying circles server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<List<dynamic>>.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>);

      if (res.statusCode == HttpStatus.ok) {

        final circles =
            apiResponse.data.map((circle) => Circle.fromJson(circle)).toList();
        return circles;
      }

      logger.e('querying circles failed: $apiResponse');
      throw QueryCircleFailure(
        statusCode: res.statusCode,
        msg: apiResponse.msg,
        status: apiResponse.status,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CirclePaginated>> fetchCirclesOfInterest() async {
    var logger = Logger();

    try {
      final res = await http.get(_uri(path: 'circles/of-interest'),
          headers: _headers());

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('querying circles of interest server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<List<dynamic>>.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>);

      if (res.statusCode == HttpStatus.ok) {
        final circles = apiResponse.data
            .map((circle) => CirclePaginated.fromJson(circle))
            .toList();
        return circles;
      }

      logger.e('querying circles of interest failed: $apiResponse');
      throw QueryCircleFailure(
        statusCode: res.statusCode,
        msg: apiResponse.msg,
        status: apiResponse.status,
      );
    } catch (e) {
      rethrow;
    }
  }

  Uri _uri({String? path, Map<String, dynamic>? queryParameters}) {
    final httpsUri = Uri(
      scheme: 'https',
      host: _baseApiHost,
      path: path != null ? '$_basePath/$path' : _basePath,
      queryParameters: queryParameters,
    );

    return httpsUri;
  }

  Map<String, String> _headers() {
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${_authenticationRepository.accessToken}',
    };
    return headers;
  }
}
