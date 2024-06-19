import 'dart:io';
import 'package:http/http.dart';
import 'package:http_interceptor/models/interceptor_contract.dart';

class VoteCircleApiInterceptor implements InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    try {
      request.headers[HttpHeaders.authorizationHeader] = 'Bearer ${_authenticationRepository.accessToken}';
    } catch (e) {
      print(e);
    }
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async =>
      response;

  @override
  Future<bool> shouldInterceptRequest() async => true;

  @override
  Future<bool> shouldInterceptResponse() async => false;
}
