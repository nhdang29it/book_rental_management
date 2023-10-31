import 'package:quan_ly_thu_vien/providers/network_provider.dart';

import '../services/elastic_search.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final elasticSearchProvider = Provider((ref) {
  final netWork = ref.watch(networkProvider);
  return ElasticService(baseUrl: "${netWork.host}:${netWork.port}", index: netWork.index, type: "_search");
});
