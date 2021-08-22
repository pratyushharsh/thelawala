import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

const String BLACK = '\u001b[30m';
const String BLUE = '\u001b[34m';
const String RED = '\u001b[31m';
const String BRIGHT_RED = '\u001b[31;1m';
const String GREEN = '\u001b[32m';
const String YELLOW = '\u001b[33m';
const String RESET = '\u001b[0m';

void initRootLogger() {
  // only enable logging for debug mode
  if (kDebugMode) {
    Logger.root.level = Level.ALL;
  } else {
    Logger.root.level = Level.OFF;
  }
  hierarchicalLoggingEnabled = true;

  // specify the levels for lower level loggers, if desired
  // Logger('SiteInfoService').level = Level.ALL;

  Logger.root.onRecord.listen((record) {
    if (!kDebugMode) {
      return;
    }

    var start = RESET;
    const end = RESET;

    switch (record.level.name) {
      case 'INFO':
        start = BLUE;
        break;
      case 'WARNING':
        start = YELLOW;
        break;
      case 'SEVERE':
        start = BRIGHT_RED;
        break;
      case 'SHOUT':
        start = RED;
        break;
    }

    print('$start${record.loggerName} : ${record.level} : ${record.time} : ${record.message}$end');
  });
}