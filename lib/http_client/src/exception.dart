class OkHttpClientException implements Exception {
  final String cause;

  const OkHttpClientException(this.cause);
}
