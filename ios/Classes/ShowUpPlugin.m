#import "ShowUpPlugin.h"
#if __has_include(<show_up/show_up-Swift.h>)
#import <show_up/show_up-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "show_up-Swift.h"
#endif

@implementation ShowUpPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftShowUpPlugin registerWithRegistrar:registrar];
}
@end
