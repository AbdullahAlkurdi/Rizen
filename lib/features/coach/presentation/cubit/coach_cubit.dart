import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/coach_message_model.dart';
import '../../data/repositories/coach_repository.dart';
import '../../../../core/injection_container.dart';
import '../../../../core/interfaces/habit_service_interface.dart';
import '../../../../core/interfaces/finance_service_interface.dart';
import '../../../../core/interfaces/note_service_interface.dart';
import '../../../../core/interfaces/domain_service_interface.dart';
import '../../../../core/interfaces/islamic_service_interface.dart';

sealed class CoachState {}

final class CoachInitial extends CoachState {}

final class CoachLoading extends CoachState {}

final class CoachLoaded extends CoachState {
  CoachLoaded({required this.messages});

  final List<CoachMessage> messages;
}

final class CoachError extends CoachState {
  CoachError(this.message);

  final String message;
}

class CoachCubit extends Cubit<CoachState> {
  CoachCubit()
      : _repository = CoachRepository(
          habitsRepository: sl<HabitServiceInterface>(),
          financeRepository: sl<FinanceServiceInterface>(),
          notesRepository: sl<NoteServiceInterface>(),
          domainLogsRepository: sl<DomainServiceInterface>(),
          prayerTimesRepository: sl<IslamicServiceInterface>(),
        ),
        super(CoachInitial());

  final CoachRepository _repository;

  Future<void> loadHistory() async {
    emit(CoachLoading());
    try {
      final history = await _repository.getChatHistory(_repository.userId);
      emit(CoachLoaded(messages: history));
    } catch (e) {
      emit(CoachError(e.toString()));
    }
  }

  Future<void> sendMessage(String message) async {
    emit(CoachLoading());
    try {
      await _repository.sendMessage(message);
      final history = await _repository.getChatHistory(_repository.userId);
      emit(CoachLoaded(messages: history));
    } catch (e) {
      emit(CoachError(e.toString()));
    }
  }

  Future<void> generateWeeklySynthesis() async {
    emit(CoachLoading());
    try {
      await _repository.getWeeklySynthesis();
      final history = await _repository.getChatHistory(_repository.userId);
      emit(CoachLoaded(messages: history));
    } catch (e) {
      emit(CoachError(e.toString()));
    }
  }
}
