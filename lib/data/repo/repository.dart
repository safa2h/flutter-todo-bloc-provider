import 'package:flutter/foundation.dart';
import 'package:todo4/data/source/source.dart';

class Repository<T> extends ChangeNotifier implements DataSource {
  final DataSource<T> localDataSource;

  Repository(this.localDataSource);

  @override
  Future<T> creatOrUpdate(data) async {
    final T newData = await localDataSource.creatOrUpdate(data);
    notifyListeners();
    return data;
  }

  @override
  Future<void> delete(data) async {
    await localDataSource.delete(data);
    notifyListeners();
  }

  @override
  Future<void> deleteAll() async {
    await localDataSource.deleteAll();
    notifyListeners();
  }

  @override
  Future<void> delteById(id) async {
    await localDataSource.delteById(id);
    notifyListeners();
  }

  @override
  Future findById(id) {
    return localDataSource.findById(id);
  }

  @override
  Future<List<T>> getAll({String searchKeyword = ''}) {
    return localDataSource.getAll(searchKeyword: searchKeyword);
  }
}
