import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';
import '../interfaces/habit_service_interface.dart';
import '../interfaces/finance_service_interface.dart';
import '../interfaces/note_service_interface.dart';
import '../interfaces/domain_service_interface.dart';
import '../interfaces/islamic_service_interface.dart';
import '../../features/habits/data/repositories/habits_repository.dart';
import '../../features/finance/data/repositories/finance_repository.dart';
import '../../features/notes/data/repositories/notes_repository.dart';
import '../../features/domains/data/repositories/domain_logs_repository.dart';
import '../../features/islamic/data/repositories/prayer_times_repository.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(Connectivity()));
  sl.registerLazySingleton<HabitServiceInterface>(() => HabitsRepository());
  sl.registerLazySingleton<FinanceServiceInterface>(() => FinanceRepository());
  sl.registerLazySingleton<NoteServiceInterface>(() => NotesRepository());
  sl.registerLazySingleton<DomainServiceInterface>(() => DomainLogsRepository());
  sl.registerLazySingleton<IslamicServiceInterface>(() => PrayerTimesRepository());
}
