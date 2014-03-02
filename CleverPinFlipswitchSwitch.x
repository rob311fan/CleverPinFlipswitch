//
//  CleverPinFlipswitchSwitch.x
//  CleverPin Flipswitch
//
//  Created by rob311 on 16.02.2014.
//  Copyright (c) 2014 rob311. All rights reserved.
//

#import "CleverPinFlipswitchSwitch.h"

@implementation CleverPinFlipswitchSwitch

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
        }
        else if (newState == FSSwitchStateOff){
        [settings setObject:[NSNumber numberWithBool:NO]forKey:@"Enabled"];
       	[settings writeToFile:[NSString stringWithFormat:@"%@/Library/Preferences/%@", NSHomeDirectory(), @"com.filippobiga.cleverpin.plist"] atomically:YES];
        }
        else {
        return;
        } 
}

@end