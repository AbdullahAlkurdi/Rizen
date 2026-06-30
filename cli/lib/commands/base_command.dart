import 'package:args/args.dart';
import 'package:rizen_cli/services/firestore_service.dart';
import 'package:rizen_cli/services/table_formatter.dart';

abstract class BaseCommand {
  final FirestoreService firestore;
  BaseCommand(this.firestore);

  Future<void> execute(ArgResults args);
}
