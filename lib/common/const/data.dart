import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

// localhost for emulator
final emulatorIp = '10.0.2.2:3000';
// localhost for simulator
final simulatorIp = '127.0.0.1:3000';
// final ip = Platform.isIOS ? simulatorIp : emulatorIp;
final ip = '192.168.0.2:3000';

// Create storage
final storage = new FlutterSecureStorage();
