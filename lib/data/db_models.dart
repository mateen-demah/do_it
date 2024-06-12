import 'package:realm/realm.dart';

part "db_models.realm.dart";

@RealmModel()
class _Task {
  @PrimaryKey()
  late ObjectId id;

  late String taskName;
  late bool complete;
  late DateTime createdOn;
}
