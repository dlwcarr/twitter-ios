//
//  Tweet.h
//  Twitter App
//
//  Created by Dane Carr on 12-01-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface Tweet : NSObject

@property (nonatomic, retain) NSDate *createdAt;
@property (nonatomic, retain) NSString *fromUser;
@property (nonatomic, retain) NSString *fromUserName;
@property (nonatomic, retain) NSNumber *tweetID;
@property (nonatomic, retain) NSURL *profileImgURL;
@property (nonatomic, retain) NSString *tweetText;

- (NSString *)age;

@end
