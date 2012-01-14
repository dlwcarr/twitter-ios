//
//  DetailViewController.h
//  Twitter App
//
//  Created by Dane Carr on 12-01-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface DetailViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;

- (NSString *) generateHTML;

@end
