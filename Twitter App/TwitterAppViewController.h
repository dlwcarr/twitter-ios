//
//  TwitterAppViewController.h
//  Twitter App
//
//  Created by Dane Carr on 12-01-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetCell.h"

@interface TwitterAppViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tweetsTable;
@property (strong, nonatomic) NSMutableArray *tweets;
@property (strong, nonatomic) NSOperationQueue *tweetOperationQueue;
@property (strong, nonatomic) NSOperationQueue *imageOperationQueue;
@property (strong, nonatomic) NSMutableDictionary *imageCache;
@property (strong, nonatomic) UIImage *avatarPlaceholder;
@property (nonatomic, assign) NSInteger *networkStatusCount;

- (void) setNetworkActivityIndicator:(BOOL)setVisible;
- (void) downloadTweets;
- (void) downloadImage:(TweetCell *)cell;

@end
