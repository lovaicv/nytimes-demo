import 'dart:io';

String testPath(String relativePath) {
  final Directory current = Directory.current;
  final String path = current.path.endsWith('/test') ? current.path : current.path + '/test';
  return path + '/' + relativePath;
}
