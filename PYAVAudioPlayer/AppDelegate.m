//
//  AppDelegate.m
//  PYAVAudioPlayer
//
//  Created by wlpiaoyi on 15/12/22.
//  Copyright © 2015年 wlpiaoyi. All rights reserved.
//

#import "AppDelegate.h"
#import "PYAVAudioPlayer.h"
#import "PYAVAudioTools.h"
#import <Utile/PYUtile.h>

@interface AppDelegate ()<AVAudioSessionDelegate>
@property (nonatomic,strong) PYAVAudioPlayer *player;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.player = [PYAVAudioPlayer new];
    [PYAVAudioTools hookremoteControlReceivedWithPlayer:self.player];
    [PYAVAudioTools hookoutputDeviceChangedWithPlayer:self.player];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error;
    NSArray<NSString *> * array =  [fm subpathsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/download",documentDir] error:&error];
    if (!error) {
        for (NSString * path in array) {
            if ([path rangeOfString:@".mp3"].length == 0) {
                continue;
            }
            [self.player addAudioUrl:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/download/%@", documentDir, path]]];
        }
        [self.player play];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void) remoteControlReceivedWithEvent: (UIEvent *) receivedEvent {
    NSLog(@"======remoteControlReceivedWithEvent");
}

@end
