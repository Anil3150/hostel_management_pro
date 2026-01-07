class Environments {
  static const String PRODUCTION = 'prod';
  static const String QAS = 'QAS';
  static const String DEV = 'dev';
  static const String LOCAL = 'local';

  static String runEnv = '';
}

class ConfigEnvironments {
  static final List<Map<String, String>> _availableEnvironments = [
    {
      'env': Environments.LOCAL,
      'url': 'https://securelandapi.hashstack.in/api',
    },
    {
      'env': Environments.DEV,
      'url': 'https://securelandapi.hashstack.in/api',
    },
    {
      'env': Environments.QAS,
      'url': 'https://securelandapi.hashstack.in/api',
    },
    {
      'env': Environments.PRODUCTION,
      'url': 'https://securelandapi.hashstack.in/api',
    },
  ];

  static Map<String, String> getEnvironments() =>
      _availableEnvironments.firstWhere(
        (d) => d['env'] == Environments.runEnv,
      );

  static String? getBaseURL() => _availableEnvironments.firstWhere(
        (d) => d['env'] == Environments.runEnv,
      )['url'];
}
