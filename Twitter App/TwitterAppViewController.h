//
//  TwitterAppViewController.h
//  Twitter App
//
//  Created by Dane Carr on 12-01-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetCell.h"

@interface TwitterAppViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tweetsTable;
@property (strong, nonatomic) NSMutableArray *tweets;
@property (strong, nonatomic) NSOperationQueue *tweetOperationQueue;
@property (strong, nonatomic) NSOperationQueue *imageOperationQueue;
@property (strong, nonatomic) NSMutableDictionary *imageCache;
@property (strong, nonatomic) UIImage *avatarPlaceholder;
@property (nonatomic, assign) NSInteger *networkStatusCount;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;

- (void) setNetworkActivityIndicator:(BOOL)setVisible;
- (void) downloadTweets:(NSString *)searchString isFromTimeline:(BOOL)isFromTimeline;
- (void) downloadImage:(TweetCell *)cell;

@end
