 import "package:flutter/foundation.dart";
import "package:universal_io/io.dart";

extension PlatformExtensionHelpes on Platform {
  bool isMobile() {
    return (kIsWeb || Platform.isAndroid || Platform.isIOS);
  }

  bool isDesktop() {
    return ((Platform.isWindows || Platform.isLinux || Platform.isMacOS) && !(kIsWeb));
  }
}
