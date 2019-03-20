#import "FlutterEditableChartsPlugin.h"
#import <flutter_editable_charts/flutter_editable_charts-Swift.h>

@implementation FlutterEditableChartsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterEditableChartsPlugin registerWithRegistrar:registrar];
}
@end
