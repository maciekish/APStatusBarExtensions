//
//  APStatusMessage.h
//  APStatusBarExtensions
//
//  Created by Maciej Swic on 2012-05-03.
//  Copyright (c) 2012 Appulize. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APStatusMessage : NSObject

@property (nonatomic, strong) NSString *message;

@property (nonatomic) NSTimeInterval duration;

+ (APStatusMessage *)statusMessageWithMessage:(NSString *)message;
+ (APStatusMessage *)statusMessageWithMessage:(NSString *)message andDuration:(NSTimeInterval)duration;

@end
