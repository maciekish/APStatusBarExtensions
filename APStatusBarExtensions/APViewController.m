//
//  APViewController.m
//  APStatusBarExtensions
//
//  Created by Maciej Swic on 2012-05-03.
//  Copyright (c) 2012 Appulize. All rights reserved.
//

#import "APViewController.h"

#import "APStatusBar.h"
#import "APStatusMessage.h"

@interface APViewController ()

@end

@implementation APViewController

@synthesize statusBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Init the status bar extension
    statusBar = [[APStatusBar alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)shortMessage:(id)sender
{
    APStatusMessage *statusMessage = [APStatusMessage statusMessageWithMessage:[NSString stringWithFormat:@"Short! %@", [NSDate date]]];
    lastPostedMessage = statusMessage;
    [statusBar queueStatusMessage:statusMessage];
}

- (IBAction)longMessage:(id)sender
{
    APStatusMessage *statusMessage = [APStatusMessage statusMessageWithMessage:[NSString stringWithFormat:@"Longer! %@", [NSDate date]] andDuration:5.0];
    lastPostedMessage = statusMessage;
    [statusBar queueStatusMessage:statusMessage];
}

- (IBAction)veryLongMessage:(id)sender
{
    APStatusMessage *statusMessage = [APStatusMessage statusMessageWithMessage:[NSString stringWithFormat:@"Very Long! %@", [NSDate date]] andDuration:600.0];
    lastPostedMessage = statusMessage;
    [statusBar queueStatusMessage:statusMessage];
}

- (IBAction)clear:(id)sender
{
    [statusBar queueClear];
}

- (IBAction)hideLast:(id)sender
{
    [statusBar hideStatusMessage:lastPostedMessage];
}

@end
