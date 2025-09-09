import 'dart:io';

const bool USE_DOCKER = true;

const String IOS_BASE_URL = 'http://http://127.0.0.1';
const String ANDROID_BASE_URL = 'http://10.0.2.2';
const String ASP_NET_PORT = '5160';
final String BASE_URL = USE_DOCKER
    ? (Platform.isAndroid ? ANDROID_BASE_URL : IOS_BASE_URL)
    : (Platform.isAndroid
          ? ANDROID_BASE_URL + ':' + ASP_NET_PORT
          : IOS_BASE_URL + ':' + ASP_NET_PORT);
