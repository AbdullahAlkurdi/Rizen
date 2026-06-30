#!/usr/bin/env dart

import 'dart:io';
import 'package:args/args.dart';
import 'package:rizen_cli/rizen_cli.dart' as cli;
import 'package:rizen_cli/auth/auth_service.dart';
import 'package:rizen_cli/commands/status_command.dart';
import 'package:rizen_cli/commands/log_command.dart';
import 'package:rizen_cli/commands/habit_command.dart';
import 'package:rizen_cli/commands/todo_command.dart';
import 'package:rizen_cli/commands/routine_command.dart';
import 'package:rizen_cli/commands/analytics_command.dart';

final parser = ArgParser()
  ..addCommand('status')
  ..addCommand('log')
  ..addCommand('habit')
  ..addCommand('todo')
  ..addCommand('routine')
  ..addCommand('analytics')
  ..addCommand('login')
  ..addCommand('logout')
  ..addCommand('help');

void main(List<String> arguments) async {
  await cli.initialize();
  final authService = AuthService();
  final firestore = FirestoreService();
  final results = parser.parse(arguments);

  if (results.arguments.isEmpty || results.command == null) {
    printHelp();
    return;
  }

  final command = results.command!;
  final protected = ['status', 'log', 'habit', 'todo', 'routine', 'analytics'];

  if (protected.contains(command.name)) {
    if (!await authService.isAuthenticated()) {
      print('Please run: rizen login');
      exit(1);
    }
  }

  try {
    switch (command.name) {
      case 'login':
        await authService.login();
        break;
      case 'logout':
        await authService.logout();
        break;
      case 'status':
        await StatusCommand(firestore).execute(results);
        break;
      case 'log':
        await LogCommand(firestore).execute(results);
        break;
      case 'habit':
        await HabitCommand(firestore).execute(results);
        break;
      case 'todo':
        await TodoCommand(firestore).execute(results);
        break;
      case 'routine':
        await RoutineCommand(firestore).execute(results);
        break;
      case 'analytics':
        await AnalyticsCommand(firestore).execute(results);
        break;
      default:
        printHelp();
    }
  } catch (e) {
    print('❌ Error: $e');
  }
}

void printHelp() {
  print('''
RizenOS CLI — AI-powered Life Operating System

COMMANDS:
  login                     Authenticate with Firebase
  logout                    Clear authentication
  status                    Show today's summary
  log <domain> --duration   Log a session
  habit list                List all habits
  habit check <name>        Check off a habit
  habit streak <name>       Show streak
  todo list --habit         List todo items
  todo check <habit> <item> Mark todo complete
  todo uncheck <habit> <item> Mark todo incomplete
  routine today             Show today's routine
  routine next              Show next upcoming block
  analytics growth          Show growth index
  analytics week            Show weekly summary per domain
  help                      Show this help
''');
}
