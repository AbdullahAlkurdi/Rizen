import 'package:args/args.dart';
import 'package:rizen_cli/services/firestore_service.dart';

class BaseCommand {
  final FirestoreService firestore;
  BaseCommand(this.firestore);

  Future<void> execute(ArgResults args) {
    throw UnimplementedError();
  }
}
