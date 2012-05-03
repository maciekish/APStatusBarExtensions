//
//  APStatusBar.h
//  APStatusBarExtensions
//
//  Created by Maciej Swic on 2012-05-03.
//  Copyright (c) 2012 Appulize. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APStatusBarViewController.h"

@interface APStatusBar : NSObject {
    CGRect statusBarFrame;
}

@property (nonatomic, strong) UIWindow *mainWindow;
@property (nonatomic, strong) UIWindow *statusWindow;

@property (nonatomic, strong) APStatusBarViewController *statusBarViewController;

- (id)init;

- (void)setStatusText:(NSString *)text;
- (void)hideStatusText;

@end
