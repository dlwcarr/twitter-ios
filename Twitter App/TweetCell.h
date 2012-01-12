//
//  TweetCell.h
//  Twitter App
//
//  Created by Dane Carr on 12-01-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetLabel.h"

@interface TweetCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *userNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *userLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet TweetLabel *tweetLabel;
@property (nonatomic, strong) IBOutlet UIImageView *profilePicImageView;
@property (nonatomic, strong) NSURL *profilePicURL;

- (void)resize;

@end
