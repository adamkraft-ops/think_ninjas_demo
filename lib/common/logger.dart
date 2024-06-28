import 'package:logger/logger.dart';

class MyLogger{
  var logger = Logger();
  static final MyLogger _singleton = MyLogger._internal();
  factory MyLogger(){
    return _singleton;
  }

  MyLogger._internal();

  setLogLevel(Level level){
    Logger.level = level;
  }

  verboseLog(String log){
    logger.v(log);
  }

  debugLog(String log){
    logger.d(log);
  }

  infoLog(String log){
    logger.i(log);
  }

  warningLog(String log){
    logger.w(log);
  }

  errorLog(String log, StackTrace stack, String classMethod){
    logger.e(log);
  }
}