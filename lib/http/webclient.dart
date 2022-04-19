import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptor/logging_interceptor.dart';

var baseUrl = Uri.parse('http://192.168.0.100:8081/transactions');

final Client client = InterceptedClient.build(
  interceptors: [
    LoggingInterceptor(),
  ],
);

