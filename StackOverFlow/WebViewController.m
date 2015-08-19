//
//  WebViewController.m
//  StackOverflow
//
//  Created by Aman Jain on 18/08/15.
//  Copyright (c) 2015 Aman. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (strong, nonatomic) UIActivityViewController *activityViewController;

@end

@implementation WebViewController

@synthesize url;

@synthesize webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Loading...";
    NSURL *myURL = [NSURL URLWithString: [self.url stringByAddingPercentEscapesUsingEncoding:
                                          NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    [self.webView loadRequest:request];
    
    //
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [[UIView appearanceWhenContainedIn:[UIAlertController class], nil] setTintColor:[UIColor colorWithRed:0.9608 green: 0.7098 blue: 0.2235 alpha: 1.0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.title = url;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (IBAction)shareText:(UIButton *)sender {
    
    NSArray *itemToShare = @[@"Can any one  Pelsae help me with" ,url];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemToShare applicationActivities:nil];
    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:itemToShare applicationActivities:nil];
    
    [self presentViewController:activityVC animated:YES completion:nil];
    [self presentViewController:activity animated:YES completion:nil];}



@end
