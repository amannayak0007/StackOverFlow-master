//
//  WebViewController.h
//  StackOverflow
//
//  Created by Aman Jain on 18/08/15.
//  Copyright (c) 2015 Aman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (copy, nonatomic) NSString *url;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
