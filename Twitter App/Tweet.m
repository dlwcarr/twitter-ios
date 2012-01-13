//
//  Tweet.m
//  Twitter App
//
//  Created by Dane Carr on 12-01-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

@synthesize createdAt;
@synthesize fromUser;
@synthesize fromUserName;
@synthesize tweetID;
@synthesize profileImgURL;
@synthesize tweetText;

//Returns a string to be displayed next to the tweet to show how long ago it was posted
- (NSString *)age {
    NSTimeInterval secondsSinceNow = -[self.createdAt timeIntervalSinceNow];
    if (secondsSinceNow == 0) {
        return @"1s";
    }
    else if (secondsSinceNow < 60.0) {
        NSNumber *seconds = [[NSNumber alloc] initWithInt:(int)secondsSinceNow];
        NSString *secondsString = [[NSString alloc] init];
        secondsString = [seconds stringValue];
        return [secondsString stringByAppendingString:@"s"];
    }
    else if (secondsSinceNow < 3600.0) {
        NSNumber *minutes = [[NSNumber alloc] initWithInt:(int)(secondsSinceNow / 60)];
        NSString *minutesString = [[NSString alloc] init];
        minutesString = [minutes stringValue];
        return [minutesString stringByAppendingString:@"m"];
    }
    else if (secondsSinceNow < 86400.0) {
        NSNumber *hours = [[NSNumber alloc] initWithInt:(int)(secondsSinceNow / 3600)];
        NSString *hoursString = [[NSString alloc] init];
        hoursString = [hours stringValue];
        return [hoursString stringByAppendingString:@"h"];
    }
    else {
        NSNumber *days = [[NSNumber alloc] initWithInt:(int)(secondsSinceNow / 86400)];
        NSString *daysString = [[NSString alloc] init];
        daysString = [days stringValue];
        return [daysString stringByAppendingString:@"d"];
    }
}

@end
