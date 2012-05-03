//
//  APStatusBar.m
//  APStatusBarExtensions
//
//  Created by Maciej Swic on 2012-05-03.
//  Copyright (c) 2012 Appulize. All rights reserved.
//

#import "APStatusBar.h"

@implementation APStatusBar

@synthesize mainWindow, statusWindow;

@synthesize statusBarViewController;

- (id)init
{
    if (self = [super init])
    {
        //Register for orientation change notifications
        
        UIDevice *device = [UIDevice currentDevice];
        [device beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:device];
        
        //Save away stuff we need to restore later
        mainWindow = [[UIApplication sharedApplication] keyWindow];
        id rootView = [mainWindow rootViewController];
        
        //Init the view controller
        
        statusBarViewController = [[APStatusBarViewController alloc] initWithNibName:@"APStatusBarViewController" bundle:nil];
        
        //Create the window
        
        statusWindow = [[UIWindow alloc] initWithFrame:[[UIApplication sharedApplication] statusBarFrame]];
        [statusWindow setWindowLevel:UIWindowLevelStatusBar+1];
        [statusWindow setRootViewController:statusBarViewController];
        [statusWindow makeKeyAndVisible];
        [statusWindow setHidden:TRUE];
        
        //Restore
        
        [mainWindow makeKeyAndVisible];
        [mainWindow setRootViewController:rootView];
    }
    return self;
}

- (void)getStatusBarFrame
{
    statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    
    DLog(@"Got status bar frame: %f,%f %f,%f", statusBarFrame.origin.x, statusBarFrame.origin.y, statusBarFrame.size.width, statusBarFrame.size.height);
    
    [[statusBarViewController view] setFrame:statusBarFrame];
}

- (void)orientationChanged:(NSNotification *)notification
{
    //Get frame again after orientation change. Wait a bit before doing it to allow the interface to update, or the wrong size is returned.
    
    [self performSelector:@selector(getStatusBarFrame) withObject:nil afterDelay:0.05];
}

- (void)setStatusText:(NSString *)text
{
    [[statusBarViewController statusLabel] setText:text];
    [[statusBarViewController statusLabel] setHidden:FALSE];
    [statusWindow setHidden:FALSE];
}

- (void)hideStatusText
{
    [[statusBarViewController statusLabel] setHidden:TRUE];
    [statusWindow setHidden:TRUE];
}

@end
