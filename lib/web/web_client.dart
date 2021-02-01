import 'package:http_interceptor/http_interceptor.dart';

import 'logging/logging_interceptor.dart';

const String baseUrl = 'http://192.168.70.110:8080';

final webClient = HttpWithInterceptor.build(interceptors: [
  LoggingInterceptor(),
]);
