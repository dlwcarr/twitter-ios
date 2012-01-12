//
//  TweetCell.m
//  Twitter App
//
//  Created by Dane Carr on 12-01-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell

@synthesize userNameLabel = _userNameLabel;
@synthesize userLabel = _userLabel;
@synthesize dateLabel = _dateLabel;
@synthesize tweetLabel = _tweetLabel;
@synthesize profilePicImageView = _profilePicImageView;
@synthesize profilePicURL = _profilePicURL;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //Initialization
        self.tweetLabel.numberOfLines = 0;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.profilePicURL = nil;
}

- (void)resize {
    CGSize userNameMaxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 130, 20);
    
    CGSize userNameSize = [self.userNameLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:15] constrainedToSize:userNameMaxSize lineBreakMode:UILineBreakModeTailTruncation];
    CGRect userNameRect = CGRectMake(60, 6, userNameSize.width, 20);
    
    CGRect userRect = CGRectMake(64 + userNameSize.width, 6, [UIScreen mainScreen].bounds.size.width - userNameSize.width - 100, 20);
    
//    CGSize maxTweetSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 66, 1000);
//    CGSize tweetSize = [self.tweetLabel.text sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:maxTweetSize lineBreakMode:UILineBreakModeWordWrap];
//    CGRect tweetRect = CGRectMake(60, 24, tweetSize.width, tweetSize.height + 6);
    
    [self.userNameLabel setFrame:userNameRect];
    [self.userLabel setFrame:userRect];
    //[self.tweetLabel setFrame:tweetRect];
}

@end
