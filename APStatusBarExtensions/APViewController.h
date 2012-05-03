//
//  APViewController.h
//  APStatusBarExtensions
//
//  Created by Maciej Swic on 2012-05-03.
//  Copyright (c) 2012 Appulize. All rights reserved.
//

#import <UIKit/UIKit.h>

@class APStatusBar, APStatusMessage;

@interface APViewController : UIViewController
{
    APStatusMessage *lastPostedMessage;
}

@property (nonatomic, strong) APStatusBar *statusBar;

- (IBAction)shortMessage:(id)sender;
- (IBAction)longMessage:(id)sender;
- (IBAction)veryLongMessage:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)hideLast:(id)sender;

@end
