#!/usr/bin/env dart

import 'dart:io';
import 'package:args/args.dart';
import 'package:rizen_cli/rizen_cli.dart' as cli;
import 'package:rizen_cli/auth/auth_service.dart';

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
  
  switch (command.name) {
    case 'login':
      await authService.login();
      break;
    case 'logout':
      await authService.logout();
      break;
    default:
      print('Command: ${command.name}');
      print('🔧 Processing... (see full implementation)');
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
  todo list --habit         List todo items
  todo check <habit> <item> Mark todo complete
  routine today             Show today's routine
  analytics growth          Show growth index
  help                      Show this help
''');
}
