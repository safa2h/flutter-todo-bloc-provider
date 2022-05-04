import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo4/data/data.dart';
import 'package:todo4/data/source/source.dart';

class HiveTaskDataSource implements DataSource<TaskEntity> {
  final Box<TaskEntity> box;

  HiveTaskDataSource(this.box);
  @override
  Future<TaskEntity> creatOrUpdate(TaskEntity data) async {
    if (data.isInBox) {
      data.save();
    } else {
      data.id = await box.add(data);
    }
    return data;
  }

  @override
  Future<void> delete(TaskEntity data) async {
    return await data.delete();
  }

  @override
  Future<void> deleteAll() {
    return box.clear();
  }

  @override
  Future<void> delteById(id) async {
    return box.delete(id);
  }

  @override
  Future<TaskEntity> findById(id) async {
    return box.values.firstWhere((element) => element.id == id);
  }

  @override
  Future<List<TaskEntity>> getAll({String searchKeyword = ''}) async {
    if (searchKeyword.isNotEmpty) {
      return box.values
          .where((element) => element.name.contains(searchKeyword))
          .toList();
    } else {
      return box.values.toList();
    }
  }
}
