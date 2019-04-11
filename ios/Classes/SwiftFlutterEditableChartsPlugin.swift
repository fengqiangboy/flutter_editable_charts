import Flutter
import UIKit

public class SwiftFlutterEditableChartsPlugin: NSObject {
@objc
  public static func register(with registrar: FlutterPluginRegistrar) {
    registrar.register(FlutterEditableChartsFactory(), withId: "com.timeyaa.com/flutter_editable_charts")
  }
}
