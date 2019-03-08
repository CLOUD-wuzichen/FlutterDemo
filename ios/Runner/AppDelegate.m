#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.

  FlutterMethodChannel* batteryChannel = [FlutterMethodChannel
                                            methodChannelWithName:@"kwl_native"
                                            binaryMessenger:controller];

    [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {

      if ([@"getStatusBarHeight" isEqualToString:call.method]) {
         result( @(  [[UIApplication sharedApplication] statusBarFrame].size.height  ) );
       }if ([@"getBatteryLevel" isEqualToString:call.method]) {
            int batteryLevel = [self getBatteryLevel];
            if (batteryLevel == -1) {
            result([FlutterError errorWithCode:@"UNAVAILABLE"
                                              message:@"电池信息不可用"
                                              details:nil]);
            }else {
              result(@(batteryLevel));
            }
       }else {
         result(FlutterMethodNotImplemented);
       }
    }];

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (int)getBatteryLevel {
  UIDevice* device = UIDevice.currentDevice;
  device.batteryMonitoringEnabled = YES;
  if (device.batteryState == UIDeviceBatteryStateUnknown) {
    return -1;
  } else {
    return (int)(device.batteryLevel * 100);
  }
}

@end
