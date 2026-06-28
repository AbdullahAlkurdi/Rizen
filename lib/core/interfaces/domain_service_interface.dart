import '../../features/domains/data/models/domain_log_model.dart';

export '../../features/domains/data/models/domain_log_model.dart';

abstract class DomainServiceInterface {
  Future<Map<String, double>> getTodayDomainScores();
  Future<List<DomainLog>> getLogsByDomain(String domainId);
  Future<void> addLog({
    required String domainId,
    required int duration,
    String? notes,
  });
}