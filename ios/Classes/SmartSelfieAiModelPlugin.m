#import "SmartSelfieAiModelPlugin.h"
#if __has_include(<smart_selfie_ai_model/smart_selfie_ai_model-Swift.h>)
#import <smart_selfie_ai_model/smart_selfie_ai_model-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "smart_selfie_ai_model-Swift.h"
#endif

@implementation SmartSelfieAiModelPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSmartSelfieAiModelPlugin registerWithRegistrar:registrar];
}
@end
