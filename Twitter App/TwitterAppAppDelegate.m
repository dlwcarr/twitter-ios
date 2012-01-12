//
//  TwitterAppAppDelegate.m
//  Twitter App
//
//  Created by Dane Carr on 12-01-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TwitterAppAppDelegate.h"
#import "TwitterAppViewController.h"
#import "Tweet.h"

@implementation TwitterAppAppDelegate {
    NSMutableArray *tweets;
}

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
//    //create sample tweet and add to tweets array
//    tweets = [NSMutableArray arrayWithCapacity:20];
//    Tweet *tweet = [[Tweet alloc] init];
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"eee, dd MMM yyyy HH:mm:ss ZZZZ"];
//    
//    tweet.createdAt = [dateFormatter dateFromString:@"Fri, 06 Jan 2012 22:30:17 +0000"];
//    tweet.fromUser = @"reddit";
//    tweet.fromUserIDString = @"811377";
//    tweet.fromUserName = @"the reddit alien";
//    tweet.tweetIDString = @"155415918216888320";
//    tweet.profileImgURL = [NSURL URLWithString:@"http://a3.twimg.com/profile_images/275642219/reddit-twitter-transp_bigger_normal.png"];
//    tweet.tweetText = @"These things happen sometimes. http://t.co/3286eRtf [fffffffuuuuuuuuuuuu] 1056 points, submitted by stabbingbrainiac [http://t.co/LNzouCiE]";
//    tweet.toUser = nil;
//    tweet.toUserIDStr = nil;
//    tweet.toUserName = nil;
//    
//    [tweets addObject:tweet];
//    
//    tweet = [[Tweet alloc] init];
//    tweet.createdAt = [dateFormatter dateFromString:@"Mon, 09 Jan 2012 19:33:13 +0000"];
//    tweet.fromUser = @"reddit";
//    tweet.fromUserIDString = @"811377";
//    tweet.fromUserName = @"the reddit alien";
//    tweet.tweetIDString = @"155415918216888320";
//    tweet.profileImgURL = [NSURL URLWithString:@"http://a3.twimg.com/profile_images/275642219/reddit-twitter-transp_bigger_normal.png"];
//    tweet.tweetText = @"REPORT: News Networks Ignore Controversial SOPA Legislation http://t.co/3k0f0FsH";
//    tweet.toUser = nil;
//    tweet.toUserIDStr = nil;
//    tweet.toUserName = nil;
//    
//    [tweets addObject:tweet];
    
//    NSURL *searchURL = [[NSURL alloc] initWithString:@"http://search.twitter.com/search.json?q=twg&rpp=20&include_entities=1"];
//    
//    __block NSMutableArray *tweets = [[NSMutableArray alloc] init];
//    
//    NSBlockOperation *getTweets = [NSBlockOperation blockOperationWithBlock: ^(void){
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:searchURL];
//        [[NSURLConnection alloc] initWithRequest:request delegate:self];
//        
//    }];
//    
//    TwitterAppViewController *twitterAppViewController = (TwitterAppViewController *) self.window.rootViewController;
//    twitterAppViewController.tweets = tweets;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
