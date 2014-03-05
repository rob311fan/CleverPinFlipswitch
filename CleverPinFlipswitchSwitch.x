//
//  CleverPinFlipswitchSwitch.x
//  CleverPin Flipswitch
//
//  Created by rob311 on 16.02.2014.
//  Copyright (c) 2014 rob311. All rights reserved.
//
#import <notify.h>
#import "CleverPinFlipswitchSwitch.h"

#ifndef GSEVENT_H
extern void GSSendAppPreferencesChanged(CFStringRef bundleID, CFStringRef key);
#endif

@implementation CleverPinFlipswitchSwitch

-(void)updatePrefs{
    notify_post("com.filippobiga.cleverpin.reloadprefs");
    GSSendAppPreferencesChanged(CFSTR("com.filippobiga.cleverpin"), CFSTR("Enabled"));
}

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier {
    NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/Preferences/%@", NSHomeDirectory(), @"com.filippobiga.cleverpin.plist"]];
    NSNumber* tweakEnabled = [settings objectForKey:@"Enabled"];    
	return [tweakEnabled boolValue]?FSSwitchStateOn:FSSwitchStateOff;

}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier {
        NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithContentsOfFile: [NSString stringWithFormat:@"%@/Library/Preferences/%@", NSHomeDirectory(), @"com.filippobiga.cleverpin.plist"]];

        if (newState == FSSwitchStateOn){
       [settings setObject:[NSNumber numberWithBool:YES]forKey:@"Enabled"];
       [settings writeToFile:[NSString stringWithFormat:@"%@/Library/Preferences/%@", NSHomeDirectory(), @"com.filippobiga.cleverpin.plist"] atomically:YES];
       [self updatePrefs];
  }
        else if (newState == FSSwitchStateOff){
        [settings setObject:[NSNumber numberWithBool:NO]forKey:@"Enabled"];
       	[settings writeToFile:[NSString stringWithFormat:@"%@/Library/Preferences/%@", NSHomeDirectory(), @"com.filippobiga.cleverpin.plist"] atomically:YES];
        [self updatePrefs];
        }
        else {
        return;
        } 

}

@end