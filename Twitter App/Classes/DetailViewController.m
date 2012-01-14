//
//  DetailViewController.m
//  Twitter App
//
//  Created by Dane Carr on 12-01-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController
@synthesize webView = _webView;
@synthesize tweet = _tweet;
@synthesize backButton = _backButton;

- (NSString *)generateHTML {
    NSString *html = @"<html><head></head><body>";
    html = [html stringByAppendingFormat:@"<b>%@</b><br>",self.tweet.fromUserName];
    html = [html stringByAppendingFormat:@"@%@<br>", self.tweet.fromUser];
    html = [html stringByAppendingFormat:@"<img src=\"%@\" alt=\"profile_pic\"/><br>", self.tweet.profileImgURL];
    html = [html stringByAppendingFormat:@"%@<br>", self.tweet.tweetText];
    html = [html stringByAppendingString:@"</body></html>"];
    
    
        
    return html;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.webView.scalesPageToFit = YES;
    [self.webView loadHTMLString:[self generateHTML] baseURL:[NSURL URLWithString:@""]];
}


- (void)viewDidUnload
{
    [self setWebView:nil];
    [self setBackButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
