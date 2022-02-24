abstract class DataSource<T> {
  Future<List<T>> getAll({String searchKeyword});
  Future<T> findById(dynamic id);
  Future<void> deleteAll();
  Future<void> delete(T data);
  Future<void> delteById(dynamic id);
  Future<T> creatOrUpdate(T data);
}
