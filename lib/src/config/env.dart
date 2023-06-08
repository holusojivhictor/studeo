import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'ACCESS_KEY')
  static const String accessKey = _Env.accessKey;

  @EnviedField(varName: 'SECRET_KEY')
  static const String secretKey = _Env.secretKey;
}
