enum EvnType { dev, prod }

class BuildConfig {
  late final EvnType environment;
  late final String appName;
  late final String baseUrl;
  late final Duration requestTimeOut;

  static final BuildConfig instance = BuildConfig._internal();

  BuildConfig._internal();

  factory BuildConfig.instantiate({
    required EvnType environment,
    required String appName,
    required String baseUrl,
    required Duration requestTimeOut,
  }) {
    instance.environment = environment;
    instance.appName = appName;
    instance.baseUrl = baseUrl;
    instance.requestTimeOut = requestTimeOut;

    return instance;
  }
}
