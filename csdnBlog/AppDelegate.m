//
//  AppDelegate.m
//  csdnBlog
//
//  Created by Colin on 14-6-16.
//  Copyright (c) 2014年 icephone. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize splashView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //添加启动动画
    [self.window makeKeyAndVisible];

    splashView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, Screen_height)];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        [splashView setImage:[UIImage imageNamed:@"bgBlog-568"]];
    }
    else
    {
        [splashView setImage:[UIImage imageNamed:@"bgBlog"]];

    }
    
    [self.window addSubview:splashView];
    [self.window bringSubviewToFront:splashView];
    
    [self performSelector:@selector(scale) withObject:nil afterDelay:0.0f];
    [self performSelector:@selector(showWord) withObject:nil afterDelay:2.5f];
    
    return YES;
}


-(void)scale
{
    UIImageView *logo_ = [[UIImageView alloc]initWithFrame:CGRectMake(119, 88, 82, 82)];
    logo_.image = [UIImage imageNamed:@"csdnLogo"];
    [splashView addSubview:logo_];
    [self setAnimation:logo_];
}

-(void)setAnimation:(UIImageView *)nowView
{
    
    [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionCurveLinear
                     animations:^
     {
         // 执行的动画code
         [nowView setFrame:CGRectMake(nowView.frame.origin.x- nowView.frame.size.width*0.1, nowView.frame.origin.y-nowView.frame.size.height*0.1, nowView.frame.size.width*1.2, nowView.frame.size.height*1.2)];
     }
                     completion:^(BOOL finished)
     {
         // 完成后执行code
         [nowView removeFromSuperview];
     }
     ];
    
}

-(void)showWord
{
    
    UIImageView *word_ = [[UIImageView alloc]initWithFrame:CGRectMake(75, Screen_height-100, 170, 29)];
    word_.image = [UIImage imageNamed:@"word_"];
    [splashView addSubview:word_];
    
    word_.alpha = 0.0;
    [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionCurveLinear
                     animations:^
     {
         word_.alpha = 1.0;
     }
                     completion:^(BOOL finished)
     {
         // 完成后执行code
         [NSThread sleepForTimeInterval:1.0f];
         [splashView removeFromSuperview];
     }
     ];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
