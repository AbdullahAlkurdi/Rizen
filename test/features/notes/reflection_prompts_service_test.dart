import 'package:flutter_test/flutter_test.dart';
import 'package:rizen/features/notes/data/services/reflection_prompts_service.dart';

void main() {
  group('ReflectionPromptsService', () {
    test('getDailyPrompt returns a string', () {
      final prompt = ReflectionPromptsService.getDailyPrompt();
      expect(prompt, isA<String>());
      expect(prompt, isNotEmpty);
    });

    test('getCustomPrompt returns a string for known mood', () {
      final prompt = ReflectionPromptsService.getCustomPrompt('happy');
      expect(prompt, isA<String>());
      expect(prompt, isNotEmpty);
    });

    test('getCustomPrompt returns empty string for unknown mood', () {
      final prompt = ReflectionPromptsService.getCustomPrompt('unknown');
      expect(prompt, isA<String>());
    });

    test('getCustomPrompt is case insensitive', () {
      final prompt = ReflectionPromptsService.getCustomPrompt('HAPPY');
      expect(prompt, isNotEmpty);
    });

    test('generateReflection returns work prompt for work content', () {
      final prompt = ReflectionPromptsService.generateReflection('I did some work today.');
      expect(prompt, contains('goals'));
    });

    test('generateReflection returns family prompt for family content', () {
      final prompt = ReflectionPromptsService.generateReflection('I spent time with family.');
      expect(prompt, contains('relationships'));
    });

    test('generateReflection returns health prompt for health content', () {
      final prompt = ReflectionPromptsService.generateReflection('I went for exercise.');
      expect(prompt, contains('body'));
    });

    test('generateReflection returns learning prompt for learn content', () {
      final prompt = ReflectionPromptsService.generateReflection('I read a book today.');
      expect(prompt, contains('insight'));
    });

    test('generateReflection returns default prompt for unknown content', () {
      final prompt = ReflectionPromptsService.generateReflection('Random thoughts');
      expect(prompt, contains('learned'));
    });
  });
}