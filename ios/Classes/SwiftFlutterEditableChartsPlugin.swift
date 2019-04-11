import Flutter
import UIKit

public class SwiftFlutterEditableChartsPlugin: NSObject {
  @objc
  public static func register(with registrar: FlutterPluginRegistrar) {
    registrar.register(FlutterEditableChartsFactory(withBinaryMessenger: registrar.messenger()),
                       withId: "com.timeyaa.com/flutter_editable_charts")
  }
}
