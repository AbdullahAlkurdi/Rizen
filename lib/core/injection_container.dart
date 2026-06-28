import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'network/dio_client.dart';
import 'network/network_info.dart';
import 'interfaces/habit_service_interface.dart';
import 'interfaces/finance_service_interface.dart';
import 'interfaces/note_service_interface.dart';
import 'interfaces/domain_service_interface.dart';
import 'interfaces/islamic_service_interface.dart';
import '../features/habits/data/repositories/habits_repository.dart';
import '../features/habits/data/repositories/shadow_tracker_repository.dart';
import '../features/habits/domain/repositories/shadow_tracker_repository_interface.dart';
import '../features/habits/domain/usecases/complete_habit_usecase.dart';
import '../features/finance/data/repositories/finance_repository.dart';
import '../features/notes/data/repositories/notes_repository.dart';
import '../features/domains/data/repositories/domain_logs_repository.dart';
import '../features/islamic/data/repositories/prayer_times_repository.dart';
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
import '../features/habits/presentation/cubit/habits_cubit.dart';
import '../features/habits/presentation/cubit/shadow_tracker_cubit.dart';

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

  sl.registerFactory(() => HabitsCubit(
    repository: HabitsRepository(),
    completeHabitUseCase: sl<CompleteHabitUseCase>(),
  ));

  sl.registerFactory(() => ShadowTrackerCubit(
    shadowTrackerRepository: sl<ShadowTrackerRepositoryInterface>(),
    getMissedItemsUseCase: sl<GetMissedItemsUseCase>(),
  ));
}