class FedaPay {
  final String version = "1.1.1";
  late String _apiKey;
  late String _apiBase;
  late String _token = "";
  late String _accountId = "";
  late String _environment = 'sandbox';
  late String _apiVersion = "v1";
  late bool _verifySslCerts = false;
  late String _caBundlePath = "";

  FedaPay();

  String get getApikey => _apiKey;

  set apiKey(String apiKey) {
    _apiKey = apiKey;
    _token = "";
  }

  String get getApiBase => _apiBase;

  set apiBase(String apiBase) => _apiBase = apiBase;

  String get getToken => _token;

  set token(String token) => _token = token;

  String get getAccountId => _accountId;

  set accountId(String accountId) => _accountId = accountId;

  String get getEnvironment => _environment;

  set environment(String environment) => _environment = environment;

  String get getApiVersion => _apiVersion;

  set apiVersion(String apiVersion) => _apiVersion = apiVersion;

  bool get getVerifySslCerts => _verifySslCerts;

  set verifySslCerts(bool verifySslCerts) => _verifySslCerts = verifySslCerts;

  String get getCaBundlePath => _caBundlePath;

  set caBundlePath(String caBundlePath) => _caBundlePath = caBundlePath;
}
