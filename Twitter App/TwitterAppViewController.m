//
//  TwitterAppViewController.m
//  Twitter App
//
//  Created by Dane Carr on 12-01-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TwitterAppViewController.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "SBJson.h"
#import <QuartzCore/QuartzCore.h>


@implementation TwitterAppViewController

@synthesize tweetsTable = _tweetsTable;
@synthesize tweets = _tweets;
@synthesize tweetOperationQueue = _tweetOperationQueue;
@synthesize imageOperationQueue = _imageOperationQueue;
@synthesize imageCache = _imageCache;
@synthesize avatarPlaceholder = _avatarPlaceholder;
@synthesize networkStatusCount = _networkStatusCount;
@synthesize searchBar = _searchBar;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
    [self.imageCache removeAllObjects];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //set up cell to be displayed
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet *tweet = [self.tweets objectAtIndex:indexPath.row];
    [cell.userLabel setLineBreakMode:UILineBreakModeTailTruncation];
    [cell.userNameLabel setLineBreakMode:UILineBreakModeTailTruncation];
    [cell.tweetLabel setLineBreakMode:UILineBreakModeWordWrap];
    cell.userNameLabel.text = tweet.fromUserName;
    cell.userLabel.text = [NSString stringWithFormat:@"@%@", tweet.fromUser];
    cell.tweetLabel.numberOfLines = 0;
    cell.tweetLabel.text = tweet.tweetText;
    cell.dateLabel.text = [tweet age];
    cell.profilePicURL = tweet.profileImgURL;
    [cell resize];
    
    if ([self.imageCache objectForKey:cell.profilePicURL] == nil) {
        cell.profilePicImageView.image = self.avatarPlaceholder;
        [self downloadImage:cell];
    }
    else {
        cell.profilePicImageView.image = [self.imageCache objectForKey:tweet.profileImgURL];
    }
    cell.profilePicImageView.layer.masksToBounds = YES;
    cell.profilePicImageView.layer.cornerRadius = 5.0;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Tweet *tweet = [self.tweets objectAtIndex:indexPath.row];
    CGSize maxLabelSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, 5000);
    CGFloat expectedHeight = [tweet.tweetText sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:maxLabelSize lineBreakMode:UILineBreakModeWordWrap].height;
    if (expectedHeight < 28) {
        return 60;
    }
    else {
        return (expectedHeight + 40);
    }
}

- (void)setNetworkActivityIndicator:(BOOL)setVisible {
    if (setVisible) {
        self.networkStatusCount = self.networkStatusCount + 1;
    }
    else {
        self.networkStatusCount = self.networkStatusCount - 1;
    }
    
    if (self.networkStatusCount > 0) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
    else {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}

- (void)downloadTweets:(NSString *)searchString isFromTimeline:(BOOL)isFromTimeline{
        
    NSBlockOperation *getTweets = [NSBlockOperation blockOperationWithBlock: ^{
        //create temporary array
        NSMutableArray *tweetArray = [[NSMutableArray alloc] init];
        //get data from twitter
        [self setNetworkActivityIndicator:YES];
        NSURL *searchURL = [[NSURL alloc] initWithString:searchString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:searchURL];
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        [self setNetworkActivityIndicator:NO];
        //create date formatter
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"eee, dd MMM yyyy HH:mm:ss ZZZZ"];
        //create JSON parser
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        id parsedData = [parser objectWithData:responseData];
        
        if (isFromTimeline) {
            NSArray *results = parsedData;
            for (NSDictionary *resultTweet in results) {
                Tweet *tweet = [[Tweet alloc] init];
                tweet.createdAt = [dateFormatter dateFromString:[resultTweet objectForKey:@"created_at"]];
                tweet.fromUser = [[resultTweet objectForKey:@"user"] objectForKey:@"screen_name"];
                tweet.fromUserName = [[resultTweet objectForKey:@"user"] objectForKey:@"name"];
                tweet.profileImgURL = [NSURL URLWithString:[[resultTweet objectForKey:@"user"] objectForKey:@"profile_image_url"]];
                tweet.tweetText = [resultTweet objectForKey:@"text"];
                tweet.tweetID = [resultTweet objectForKey:@"id"];
                [tweetArray addObject:tweet];
            }
        }
        else {
            NSArray *results = [parsedData objectForKey:@"results"];
            //parse JSON into a Tweet object
            for (NSDictionary *resultTweet in results) {
                Tweet *tweet = [[Tweet alloc] init];
                tweet.createdAt = [dateFormatter dateFromString:[resultTweet objectForKey:@"created_at"]];
                tweet.fromUser = [resultTweet objectForKey:@"from_user"];
                tweet.fromUserName = [resultTweet objectForKey:@"from_user_name"];
                tweet.tweetID = [resultTweet objectForKey:@"id"];
                tweet.profileImgURL = [NSURL URLWithString:[resultTweet objectForKey:@"profile_image_url"]];
                tweet.tweetText = [resultTweet objectForKey:@"text"];
                [tweetArray addObject:tweet];
            }
        }
        
        //copy temporary tweet array back to main tweet array, refresh table
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.tweets = tweetArray;
            [self.tweetsTable reloadData];
        }];
        
    }];
    
    [self.tweetOperationQueue addOperation:getTweets];
}

- (void) downloadImage:(TweetCell *)cell{
    [self.imageOperationQueue addOperationWithBlock:^{
        [self setNetworkActivityIndicator:YES];
        NSURL *cellURL = cell.profilePicURL;
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:cellURL];
        NSData *imageData = [NSURLConnection sendSynchronousRequest:request returningResponse: nil error:nil];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
            
        if (image != nil) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.imageCache setObject:image forKey:cellURL];
                if (cellURL == cell.profilePicURL) { //Check if cell has changed
                    cell.profilePicImageView.image = image;
                    [cell setNeedsDisplay];
                    [self setNetworkActivityIndicator:NO];
                }
            }];
        }
    }];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText == @"") {
        [self downloadTweets:@"http://api.twitter.com/1/statuses/public_timeline.json" isFromTimeline:YES];
        [searchBar resignFirstResponder];
    }
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *searchText = searchBar.text;
    searchText = [searchText stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *searchURL = [NSString stringWithFormat:@"http://search.twitter.com/search.json?q=%@&rpp=25&include_entities=1&locale=en", searchText];
    [self downloadTweets:searchURL isFromTimeline:NO];
    [self.tweetsTable setNeedsDisplay];
    [searchBar resignFirstResponder];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tweetOperationQueue = [[NSOperationQueue alloc] init];
    self.imageOperationQueue = [[NSOperationQueue alloc] init];
    [self.imageOperationQueue setMaxConcurrentOperationCount:1];
    NSString* imageName = [[NSBundle mainBundle] pathForResource:@"twitter_bird" ofType:@"png"];
    self.avatarPlaceholder = [[UIImage alloc] initWithContentsOfFile:imageName];
    self.imageCache = [[NSMutableDictionary alloc] init];
    [self downloadTweets:@"http://api.twitter.com/1/statuses/public_timeline.json" isFromTimeline:YES];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTweetsTable:nil];
    [self setSearchBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {

}

@end
