//
//  TweetLabel.m
//  Twitter App
//
//  Created by Dane Carr on 12-01-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TweetLabel.h"

@implementation TweetLabel

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 0, 0, 0};
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
