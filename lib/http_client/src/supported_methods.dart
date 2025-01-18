enum SupportedMethods {
  post('POST'),
  get('GET'),
  put('PUT'),
  patch('PATCH'),
  delete('DELETE');

  final String name;

  const SupportedMethods(this.name);
}
