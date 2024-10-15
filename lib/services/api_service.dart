// lib/services/api_service.dart

abstract class ApiService<T> {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<List<T>> getAll();
  Future<T> getById(String id);
  Future<T> create(T item);
  Future<T> update(String id, T item);
  Future<void> delete(String id);
}
