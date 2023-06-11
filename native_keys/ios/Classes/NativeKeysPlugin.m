#import "NativeKeysPlugin.h"
#if __has_include(<native_keys/native_keys-Swift.h>)
#import <native_keys/native_keys-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "native_keys-Swift.h"
#endif

@implementation NativeKeysPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNativeKeysPlugin registerWithRegistrar:registrar];
}
@end
