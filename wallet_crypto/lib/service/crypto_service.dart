import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:wallet_crypto/model/data.dart';

part 'crypto_service.g.dart';

@RestApi(baseUrl: "")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("https://api.coincap.io/v2/assets")
  Future<Data> getCrypto();
}
