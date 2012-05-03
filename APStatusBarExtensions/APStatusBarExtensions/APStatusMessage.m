//
//  APStatusMessage.m
//  APStatusBarExtensions
//
//  Created by Maciej Swic on 2012-05-03.
//  Copyright (c) 2012 Appulize. All rights reserved.
//

#import "APStatusMessage.h"

@implementation APStatusMessage

@synthesize message, duration;

+ (APStatusMessage *)statusMessageWithMessage:(NSString *)message
{
    APStatusMessage *statusMessage = [[APStatusMessage alloc] init];
    [statusMessage setMessage:message];
    [statusMessage setDuration:1.5];
    
    return statusMessage;
}

+ (APStatusMessage *)statusMessageWithMessage:(NSString *)message andDuration:(NSTimeInterval)duration
{
    APStatusMessage *statusMessage = [[APStatusMessage alloc] init];
    [statusMessage setMessage:message];
    [statusMessage setDuration:duration];
    
    return statusMessage;
}

@end
