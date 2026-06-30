import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'network/dio_client.dart';
import 'network/network_info.dart';
import 'interfaces/habit_service_interface.dart';
import 'interfaces/finance_service_interface.dart';
import 'interfaces/note_service_interface.dart';
import 'interfaces/domain_service_interface.dart';
import 'interfaces/islamic_service_interface.dart';
import 'services/tutorial_service.dart';
import 'config/app_config.dart';
import 'services/voice_parser_service.dart';
import 'services/voice_log_orchestrator.dart';
import 'services/gemini_service.dart';
import '../features/voice/presentation/cubit/voice_cubit.dart';
import '../features/analytics/data/repositories/analytics_repository.dart';
import '../features/analytics/presentation/cubit/analytics_cubit.dart';
import '../features/coach/presentation/cubit/voice_cubit.dart';
import '../features/coach/data/repositories/coach_repository.dart';
import '../features/habits/data/repositories/habits_repository.dart';
import '../features/habits/data/repositories/shadow_tracker_repository.dart';
import '../features/habits/domain/repositories/shadow_tracker_repository_interface.dart';
import '../features/habits/domain/usecases/complete_habit_usecase.dart';
import '../features/finance/data/repositories/finance_repository.dart';
import '../features/notes/data/repositories/notes_repository.dart';
import '../features/domains/data/repositories/domain_logs_repository.dart';
import '../features/islamic/data/repositories/prayer_times_repository.dart';
import '../features/home/data/services/sleep_tracking_service.dart';
import '../features/home/presentation/cubit/sleep_cubit.dart';
import '../features/todo/data/datasources/todo_remote_datasource.dart';
import '../features/todo/data/repositories/todo_repository_impl.dart';
import '../features/todo/domain/repositories/todo_repository_interface.dart';
import '../features/todo/domain/usecases/get_todo_list_usecase.dart';
import '../features/todo/domain/usecases/save_todo_list_usecase.dart';
import '../features/todo/domain/usecases/check_todo_item_usecase.dart';
import '../features/todo/domain/usecases/uncheck_todo_item_usecase.dart';
import '../features/todo/domain/usecases/compute_todo_score_usecase.dart';
import '../features/todo/domain/usecases/get_missed_items_usecase.dart';
import '../features/todo/presentation/cubit/todo_cubit.dart';
import '../features/dashboard/presentation/cubit/dashboard_todo_cubit.dart';
import '../features/habits/presentation/cubit/habits_cubit.dart';
import '../features/habits/presentation/cubit/shadow_tracker_cubit.dart';
import '../features/home/data/repositories/sleep_repository.dart';
import '../features/home/data/services/sleep_detector_service.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(Connectivity()));
  sl.registerLazySingleton<HabitServiceInterface>(() => HabitsRepository());
  sl.registerLazySingleton<FinanceServiceInterface>(() => FinanceRepository());
  sl.registerLazySingleton<NoteServiceInterface>(() => NotesRepository());
  sl.registerLazySingleton<DomainServiceInterface>(() => DomainLogsRepository());
  sl.registerLazySingleton<IslamicServiceInterface>(() => PrayerTimesRepository());

  sl.registerLazySingleton<TodoRemoteDataSource>(
    () => TodoRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<TodoRepositoryInterface>(
    () => TodoRepositoryImpl(),
  );

  sl.registerLazySingleton(() => GetTodoListUseCase(sl<TodoRepositoryInterface>()));
  sl.registerLazySingleton(() => ComputeTodoScoreUseCase());
  sl.registerLazySingleton(() => SaveTodoListUseCase(sl<TodoRepositoryInterface>(), sl<ComputeTodoScoreUseCase>()));
  sl.registerLazySingleton(() => CheckTodoItemUseCase(sl<TodoRepositoryInterface>()));
  sl.registerLazySingleton(() => UncheckTodoItemUseCase(sl<TodoRepositoryInterface>()));
  sl.registerLazySingleton(() => GetMissedItemsUseCase(sl<TodoRepositoryInterface>()));

  sl.registerLazySingleton(() => CoachRepository(
    habitsRepository: sl<HabitServiceInterface>(),
    financeRepository: sl<FinanceServiceInterface>(),
    notesRepository: sl<NoteServiceInterface>(),
    domainLogsRepository: sl<DomainServiceInterface>(),
    prayerTimesRepository: sl<IslamicServiceInterface>(),
    todoRepository: sl<TodoRepositoryInterface>(),
    getMissedItemsUseCase: sl<GetMissedItemsUseCase>(),
    voiceLogOrchestrator: sl<VoiceLogOrchestrator>(),
  ));

  sl.registerLazySingleton<ShadowTrackerRepositoryInterface>(
    () => ShadowTrackerRepository(),
  );

  sl.registerLazySingleton(() => CompleteHabitUseCase(
    habitsRepository: HabitsRepository(),
    todoRepository: sl<TodoRepositoryInterface>(),
    computeTodoScore: sl<ComputeTodoScoreUseCase>(),
    shadowTrackerRepository: sl<ShadowTrackerRepositoryInterface>(),
  ));

  sl.registerFactory(() => TodoCubit(
    getTodoList: sl(),
    saveTodoList: sl(),
    checkItem: sl(),
    uncheckItem: sl(),
    computeScore: sl(),
  ));

  sl.registerFactory(() => DashboardTodoCubit(
    getTodoListsByDate: sl<TodoRepositoryInterface>().getTodoListsByDate,
  ));

  sl.registerFactory(() => HabitsCubit(
    repository: HabitsRepository(),
    completeHabitUseCase: sl<CompleteHabitUseCase>(),
  ));

  sl.registerFactory(() => ShadowTrackerCubit(
    shadowTrackerRepository: sl<ShadowTrackerRepositoryInterface>(),
    getMissedItemsUseCase: sl<GetMissedItemsUseCase>(),
  ));

  sl.registerLazySingleton(() => SleepLogRepository());

  sl.registerLazySingleton(() => SleepDetectorService(sl<SleepLogRepository>()));

  sl.registerLazySingleton(() => SleepTrackingService(
    firestore: FirebaseFirestore.instance,
    firebaseAuth: FirebaseAuth.instance,
    repository: sl<SleepLogRepository>(),
  ));

  sl.registerFactory(() => SleepCubit(
    repository: sl<SleepLogRepository>(),
    sleepDetectorService: sl<SleepDetectorService>(),
    sleepTrackingService: sl<SleepTrackingService>(),
  ));

  sl.registerLazySingleton(() => TutorialService());

  sl.registerLazySingleton(
    () => VoiceParserService(
      geminiApiKey: AppConfig.geminiApiKey,
      dio: Dio(),
    ),
  );

  sl.registerLazySingleton(
    () => VoiceLogOrchestrator(
      habitsRepository: sl<HabitServiceInterface>(),
      domainLogsRepository: sl<DomainServiceInterface>(),
      notesRepository: sl<NoteServiceInterface>(),
      todoRepository: sl<TodoRepositoryInterface>(),
      completeHabitUseCase: sl<CompleteHabitUseCase>(),
      checkTodoItemUseCase: sl<CheckTodoItemUseCase>(),
      uncheckTodoItemUseCase: sl<UncheckTodoItemUseCase>(),
    ),
  );

  sl.registerLazySingleton(
    () => AnalyticsRepository(
      firestore: sl(),
      uid: sl<FirebaseAuth>().currentUser?.uid ?? '',
    ),
  );

  sl.registerLazySingleton(() => GeminiService());

  sl.registerFactory(
    () => CoachVoiceCubit(geminiService: sl<GeminiService>()),
  );

  sl.registerFactory(
    () => VoiceCubit(
      parserService: sl<VoiceParserService>(),
      orchestrator: sl<VoiceLogOrchestrator>(),
    ),
  );

  sl.registerFactory(
    () => AnalyticsCubit(
      repository: sl(),
    ),
  );
}