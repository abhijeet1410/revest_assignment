mixin Environment {
  static const String environment =
      String.fromEnvironment("env", defaultValue: 'dev');

  static const String baseApiUrl = environment == 'prod'
      ? 'https://dog.ceo/api'
      : 'https://dog.ceo/api';

  static const fontFamily = 'Gilory';
}
