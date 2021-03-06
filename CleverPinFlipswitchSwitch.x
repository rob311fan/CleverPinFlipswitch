//
//  CleverPinFlipswitchSwitch.x
//  CleverPin Flipswitch
//
//  Created by rob311 on 16.02.2014.
//  Copyright (c) 2014 rob311. All rights reserved.
//
#import <FSSwitchDataSource.h>
#import "FSSwitchPanel.h"
#import <objc/runtime.h>
#import <notify.h>
#import "CleverPinFlipswitchSwitch.h"

#ifndef GSEVENT_H
extern void GSSendAppPreferencesChanged(CFStringRef bundleID, CFStringRef key);
#endif

static BOOL isDisabled;

@implementation CleverPinFlipswitchSwitch

-(void)updatePrefs{
    NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithContentsOfFile: [NSString stringWithFormat:@"%@/Library/Preferences/%@", NSHomeDirectory(), @"com.filippobiga.cleverpin.plist"]];      
    [settings setObject:[NSNumber numberWithBool:isDisabled]forKey:@"Enabled"];
    [settings writeToFile:[NSString stringWithFormat:@"%@/Library/Preferences/%@", NSHomeDirectory(), @"com.filippobiga.cleverpin.plist"] atomically:YES];
    notify_post("com.filippobiga.cleverpin.reloadprefs");
    GSSendAppPreferencesChanged(CFSTR("com.filippobiga.cleverpin"), CFSTR("Enabled"));
}

- (NSString *)titleForSwitchIdentifier:(NSString *)switchIdentifier {
    return @"CleverPin";
}

static void CleverPinFlipswitchSwitchChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
    [[FSSwitchPanel sharedPanel] stateDidChangeForSwitchIdentifier:[NSBundle bundleForClass:[CleverPinFlipswitchSwitch class]].bundleIdentifier];
}



+ (void)load
{
    CFNotificationCenterRef center = CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterAddObserver(center, NULL, CleverPinFlipswitchSwitchChanged, CFSTR("com.filippobiga.cleverpin.reloadprefs"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier {
    NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/Preferences/%@", NSHomeDirectory(), @"com.filippobiga.cleverpin.plist"]];
    NSNumber* tweakEnabled = [settings objectForKey:@"Enabled"];    
    return [tweakEnabled boolValue]?FSSwitchStateOn:FSSwitchStateOff;

}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier {

    if (newState == FSSwitchStateOn){
    isDisabled = YES;
    }
    else if (newState == FSSwitchStateOff){
    isDisabled = NO; 
    }
    else {
    return;
    }   
  [self updatePrefs];
}
@end