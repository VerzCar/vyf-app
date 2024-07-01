import 'dart:convert';
import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:vote_circle_api/vote_circle_api.dart';

part 'api_errors.dart';

class VoteCircleApiClient implements IVoteCircleApiClient {
  VoteCircleApiClient({required authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  final IAuthenticationRepository _authenticationRepository;
  final String _baseApiHost = 'vyf-vote-circle-309d72dfd728.herokuapp.com';
  final String _basePath = 'v1/api/vote-circle';

  @override
  Future<Circle> fetchCircle(int id) async {
    var logger = Logger();

    try {
      final res = await http.get(
        _uri(path: 'circle/$id'),
        headers: await _headers,
      );

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
      final res = await http.get(
        _uri(path: 'circles'),
        headers: await _headers,
      );

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
      final res = await http.get(
        _uri(path: 'circles/of-interest'),
        headers: await _headers,
      );

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

  @override
  Future<List<CirclePaginated>> fetchCirclesFiltered({
    required String name,
  }) async {
    var logger = Logger();

    try {
      final res = await http.get(
        _uri(path: 'circles/$name'),
        headers: await _headers,
      );

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('querying filtered circles server error: $res');
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

      logger.e('querying filtered circles failed: $apiResponse');
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
  Future<List<Ranking>> fetchRankings(int circleId) async {
    var logger = Logger();

    try {
      final res = await http.get(
        _uri(path: 'rankings/$circleId'),
        headers: await _headers,
      );

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('querying rankings server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<List<dynamic>>.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>);

      if (res.statusCode == HttpStatus.ok) {
        final rankings = apiResponse.data
            .map((ranking) => Ranking.fromJson(ranking))
            .toList();
        return rankings;
      }

      logger.e('querying rankings failed: $apiResponse');
      throw QueryRankingFailure(
        statusCode: res.statusCode,
        msg: apiResponse.msg,
        status: apiResponse.status,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CircleCandidate> fetchCircleCandidates(
    int circleId,
    CircleCandidatesFilter? filter,
  ) async {
    var logger = Logger();

    try {
      final queryParams = filter?.toParamMap();
      final res = await http.get(
        _uri(path: 'circle-candidates/$circleId', queryParameters: queryParams),
        headers: await _headers,
      );

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('querying circle candidates server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>);

      if (res.statusCode == HttpStatus.ok) {
        return CircleCandidate.fromJson(apiResponse.data);
      }

      logger.e('querying circle candidates failed: $apiResponse');
      throw QueryCandidatesFailure(
        statusCode: res.statusCode,
        msg: apiResponse.msg,
        status: apiResponse.status,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CircleVoter> fetchCircleVoters(int circleId) async {
    var logger = Logger();

    try {
      final res = await http.get(
        _uri(path: 'circle-voters/$circleId'),
        headers: await _headers,
      );

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('querying circle voters server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>);

      if (res.statusCode == HttpStatus.ok) {
        return CircleVoter.fromJson(apiResponse.data);
      }

      logger.e('querying circle voters failed: $apiResponse');
      throw QueryVotersFailure(
        statusCode: res.statusCode,
        msg: apiResponse.msg,
        status: apiResponse.status,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Circle> createCircle(CircleCreateRequest circleRequest) async {
    var logger = Logger();

    try {
      var jsonBody = jsonEncode(circleRequest.toJson());

      final res = await http.post(
        _uri(path: 'circle'),
        headers: await _headers,
        body: jsonBody,
      );

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('creating circle server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>);

      if (res.statusCode == HttpStatus.ok) {
        return Circle.fromJson(apiResponse.data);
      }

      logger.e('creating circle failed: $apiResponse');
      throw CreateCircleFailure(
        statusCode: res.statusCode,
        msg: apiResponse.msg,
        status: apiResponse.status,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Circle> updateCircle(
    int circleId,
    CircleUpdateRequest circleUpdateRequest,
  ) async {
    var logger = Logger();

    try {
      var jsonBody = jsonEncode(circleUpdateRequest.toJson());

      final res = await http.put(
        _uri(path: 'circle/$circleId'),
        headers: await _headers,
        body: jsonBody,
      );

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('updating circle server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>);

      if (res.statusCode == HttpStatus.ok) {
        return Circle.fromJson(apiResponse.data);
      }

      logger.e('updating circle failed: $apiResponse');
      throw UpdateCircleFailure(
        statusCode: res.statusCode,
        msg: apiResponse.msg,
        status: apiResponse.status,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteCircle(int circleId) async {
    var logger = Logger();

    try {
      final res = await http.delete(
        _uri(path: 'circle/$circleId'),
        headers: await _headers,
      );

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('deleting circle server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<String>.fromJson(jsonDecode(res.body));

      if (res.statusCode == HttpStatus.ok) {
        return;
      }

      logger.e('deleting circle failed: $apiResponse');
      throw DeleteCircleFailure(
        statusCode: res.statusCode,
        msg: apiResponse.msg,
        status: apiResponse.status,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> eligibleToBeInCircle(int circleId) async {
    var logger = Logger();

    try {
      final res = await http.get(
        _uri(path: 'circle/$circleId/eligible'),
        headers: await _headers,
      );

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('querying eligible state of circle server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<bool>.fromJson(jsonDecode(res.body));

      if (res.statusCode == HttpStatus.ok) {
        return apiResponse.data;
      }

      logger.e('querying eligible state of circle failed: $apiResponse');
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
  Future<Candidate> joinCircleAsCandidate(int circleId) async {
    var logger = Logger();

    try {
      final res = await http.post(
        _uri(path: 'circle-candidates/$circleId/join'),
        headers: await _headers,
      );

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('join circle as candidate server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>);

      if (res.statusCode == HttpStatus.ok) {
        return Candidate.fromJson(apiResponse.data);
      }

      logger.e('join circle as candidate failed: $apiResponse');
      throw JoinCircleFailure(
        statusCode: res.statusCode,
        msg: apiResponse.msg,
        status: apiResponse.status,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Voter> joinCircleAsVoter(int circleId) async {
    var logger = Logger();

    try {
      final res = await http.post(
        _uri(path: 'circle-voters/$circleId/join'),
        headers: await _headers,
      );

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('join circle as voter server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>);

      if (res.statusCode == HttpStatus.ok) {
        return Voter.fromJson(apiResponse.data);
      }

      logger.e('join circle as voter failed: $apiResponse');
      throw JoinCircleFailure(
        statusCode: res.statusCode,
        msg: apiResponse.msg,
        status: apiResponse.status,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> leaveCircleAsCandidate(int circleId) async {
    var logger = Logger();

    try {
      final res = await http.delete(
        _uri(path: 'circle-candidates/$circleId/leave'),
        headers: await _headers,
      );

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('leave circle as candidate server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<String>.fromJson(jsonDecode(res.body));

      if (res.statusCode == HttpStatus.ok) {
        return apiResponse.data;
      }

      logger.e('leave circle as candidate failed: $apiResponse');
      throw LeaveCircleFailure(
        statusCode: res.statusCode,
        msg: apiResponse.msg,
        status: apiResponse.status,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> leaveCircleAsVoter(int circleId) async {
    var logger = Logger();

    try {
      final res = await http.delete(
        _uri(path: 'circle-voters/$circleId/leave'),
        headers: await _headers,
      );

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('leave circle as voter server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<String>.fromJson(jsonDecode(res.body));

      if (res.statusCode == HttpStatus.ok) {
        return apiResponse.data;
      }

      logger.e('leave circle as voter failed: $apiResponse');
      throw LeaveCircleFailure(
        statusCode: res.statusCode,
        msg: apiResponse.msg,
        status: apiResponse.status,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> createVote(
    int circleId,
    VoteCreateRequest voteCreateRequest,
  ) async {
    var logger = Logger();

    try {
      var jsonBody = jsonEncode(voteCreateRequest.toJson());

      final res = await http.post(
        _uri(path: 'vote/$circleId'),
        headers: await _headers,
        body: jsonBody,
      );

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('creating vote server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<bool>.fromJson(jsonDecode(res.body));

      if (res.statusCode == HttpStatus.ok) {
        return apiResponse.data;
      }

      logger.e('creating vote failed: $apiResponse');
      throw CreateVoteFailure(
        statusCode: res.statusCode,
        msg: apiResponse.msg,
        status: apiResponse.status,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> revokeVote(int circleId) async {
    var logger = Logger();

    try {
      final res = await http.post(
        _uri(path: 'vote/revoke/$circleId'),
        headers: await _headers,
      );

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('revoking vote server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<bool>.fromJson(jsonDecode(res.body));

      if (res.statusCode == HttpStatus.ok) {
        return apiResponse.data;
      }

      logger.e('revoking vote failed: $apiResponse');
      throw RevokeVoteFailure(
        statusCode: res.statusCode,
        msg: apiResponse.msg,
        status: apiResponse.status,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserOption> fetchUserOption() async {
    var logger = Logger();

    try {
      final res = await http.get(
        _uri(path: 'user-option'),
        headers: await _headers,
      );

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('querying user options server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>);

      if (res.statusCode == HttpStatus.ok) {
        return UserOption.fromJson(apiResponse.data);
      }

      logger.e('querying user options failed: $apiResponse');
      throw QueryUserOptionFailure(
        statusCode: res.statusCode,
        msg: apiResponse.msg,
        status: apiResponse.status,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Commitment> updateCommitment(
    int circleId,
    CircleCandidateCommitmentRequest commitmentRequest,
  ) async {
    var logger = Logger();

    try {
      var jsonBody = jsonEncode(commitmentRequest.toJson());

      final res = await http.post(
        _uri(path: 'circle-candidates/$circleId/commitment'),
        headers: await _headers,
        body: jsonBody,
      );

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('updating commitment server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<String>.fromJson(jsonDecode(res.body));

      if (res.statusCode == HttpStatus.ok) {
        return CommitmentEnumMap[apiResponse.data]!;
      }

      logger.e('updating commitment failed: $apiResponse');
      throw UpdateCommitmentFailure(
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

  Future<Map<String, String>> get _headers async {
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${await _authenticationRepository.jwtToken}',
    };
    return headers;
  }
}
