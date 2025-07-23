import 'package:cellula_task/features/ai_suggestion/domain/usecase/get_weather_suggestion_use_case.dart';
import 'package:cellula_task/features/ai_suggestion/presentation/controller/suggestion_state.dart';
import 'package:cellula_task/features/weather/domain/Entity/weather.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuggestionCubit extends Cubit<SuggestionState> {
  final GetWeatherSuggestionUseCase useCase;

  SuggestionCubit(this.useCase) : super(SuggestionInitial());

  Future<void> getSuggestion(CurrentWeather weather, String name) async {
    emit(SuggestionLoading());
    final result = await useCase(currentWeather: weather, userName: name);
    result.fold(
      (failure) => emit(SuggestionError("Failed to get suggestion")),
      (message) => emit(SuggestionLoaded(message)),
    );
  }
}
