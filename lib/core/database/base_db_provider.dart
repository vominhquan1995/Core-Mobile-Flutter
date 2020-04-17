abstract class BaseProvider<T> {
  Future<bool> insert(T p);
  Future<bool> update();
  Future<bool> delete();
  Future<T> select();
}
