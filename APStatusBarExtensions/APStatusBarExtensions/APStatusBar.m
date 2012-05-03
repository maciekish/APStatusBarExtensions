//
//  APStatusBar.m
//  APStatusBarExtensions
//
//  Created by Maciej Swic on 2012-05-03.
//  Copyright (c) 2012 Appulize. All rights reserved.
//

#import "APStatusBar.h"

#import "APStatusMessage.h"

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
        
        //Init queue
        
        queuedStatusMessages = [[NSMutableArray alloc] init];
        queueRunning = FALSE;
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

- (void)queueStatusMessage:(APStatusMessage *)statusMessage
{
    [queuedStatusMessages addObject:statusMessage];
    
    DLog(@"Status Messages in queue after adding %d", [queuedStatusMessages count]);
    
    if (!queueRunning)
        [self processQueue];
}

- (void)processQueue
{
    if (lastMessageShown)
        [queuedStatusMessages removeObject:lastMessageShown];
    
    DLog(@"Status Messages in queue before processing %d", [queuedStatusMessages count]);
    
    if ([queuedStatusMessages count] > 0)
    {
        DLog(@"Processing next queued message");
        
        APStatusMessage *statusMessage = [queuedStatusMessages objectAtIndex:0];
        [self setStatusText:[statusMessage message]];
        lastMessageShown = statusMessage;
        [self performSelector:@selector(processQueue) withObject:nil afterDelay:[statusMessage duration]];
        queueRunning = TRUE;
    }
    else
    {
        DLog(@"Queue finished");
        
        [self hideStatusText];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(processQueue) object:nil];
        queueRunning = FALSE;
    }
}

- (void)hideStatusMessage:(APStatusMessage *)statusMessage
{
    if ([queuedStatusMessages containsObject:statusMessage]) {
        if ([queuedStatusMessages count] == 1)
            [self queueClear];
        else
        {
            [queuedStatusMessages removeObject:statusMessage];
            [self processQueue];
        }
    }
}

- (void)queueClear
{
    queueRunning = FALSE;
    [queuedStatusMessages removeAllObjects];
    [self processQueue];
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
